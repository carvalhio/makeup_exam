Rails.application.routes.draw do
  
  resources :exam_periods

  root "home#index"
  get "reports/index"
  get "home/about"

  resources :exam_requests
  resources :students
  resources :school_classes
  
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "reports", to: "reports#index"
  get "stages/:stage", to: "exam_periods#stage", as: :stage
end
