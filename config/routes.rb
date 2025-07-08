Rails.application.routes.draw do
  # Admin namespace
  namespace :admin do
    resources :schedules
    resource :about_page, only: [:edit, :update]
  end

  # Public pages
  root "pages#home"
  get "pages/home"
  get "/about", to: "pages#about"
  get "/schedule", to: "pages#schedule"
  get "/photos", to: "pages#photos"

  # Health checks
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
