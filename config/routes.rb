Rails.application.routes.draw do
  namespace :admin do
    resources :features
    resources :exercises do
      member do
        get :preview
      end
    end
  end

  get "why", to: "demo#index"
  get "test", to: "demo#test"

  resources :exercises, only: [ :index, :show ] do
    collection do
      get :join
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "exercises#index"
end
