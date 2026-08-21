Rails.application.routes.draw do
  get "aee/index"
  root "home#index"

  get "home/about"
  get "reports/index"
  get "reports", to: "reports#index"
  get "aee", to: "aee#index", as: :aee

  resources :students

  resources :school_classes do
  member do
    get :attendance_sheet
  end

  collection do
    get :attendance_sheets
  end

  resources :students, only: :index
end

resources :test_applications, only: [ :show, :new, :create ]

resources :exam_periods, only: [ :show ] do
    member do
      get :print_map
      get :attendance_list
   end

    resources :exam_requests, only: [
      :index,
      :show,
      :new,
      :create,
      :edit,
      :update,
      :destroy
  ]  do
      collection do
        get :find_or_redirect
      end
    end
  end

  get "stages/:stage", to: "exam_periods#stage", as: :stage

  # Rails system routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
