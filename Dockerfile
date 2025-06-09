# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Install base packages AND libpq-dev
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libjemalloc2 libvips sqlite3 libpq-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# ---- BUILD STAGE ----
FROM base AS build

# Install build tools and PostgreSQL headers needed for native gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git node-gyp pkg-config python-is-python3 \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ARG NODE_VERSION=18.20.8
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH

RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Install JavaScript dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy full app code
COPY . .

RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets (dummy key to avoid secrets error)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Remove unnecessary dev files
RUN rm -rf node_modules

# ---- FINAL STAGE ----
FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
