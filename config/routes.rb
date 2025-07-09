Rails.application.routes.draw do
  # Sessions routes (add right under the existing line or near your root path)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :photos

  # Admin namespace
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :schedules
    resource :about_page, only: [:edit, :update]
    resources :photos
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
