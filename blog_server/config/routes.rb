Rails.application.routes.draw do
  # get "likes/index"
  # get "likes/show"
  # get "likes/create"
  # get "likes/update"
  # get "categories/index"
  # get "categories/show"
  # get "categories/create"
  # get "categories/update"
  # get "comments/index"
  # get "comments/show"
  # get "comments/create"
  # get "comments/update"
  # get "comments/destroy"
  # get "users/index"
  # get "users/show"
  # get "users/create"
  # get "users/update"
  # get "posts/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # rote to get all the posts
  namespace :v1 do
    resources :posts, only: [ :index, :show, :update, :destroy ]
    resources :users, only: [ :index, :show, :create, :update ]
    # resources :likes, only: [ :index, :show, :create, :update, :destroy ]
    resources :comments, only: [ :index, :show, :create, :update, :destroy ]
    resources :categories, only: [ :index, :show, :create, :update :destroy ]

    resources :user do
      resources :comments, only: [ :index, :show ]
      resources :posts, only: [ :index, :show, :create, :destroy ]
      resources :likes, only: [ :index ]
    end
    resources :categories do
      resources :posts, only: [ :index, :create ]
    end
    resources :posts do
      resources :comments, only: [ :index, :show, :create ]
      resources :likes, only: [ :index, :create ]
    end
    resources :comments do
      resources :likes, only: [ :index, :create ]
    end
  end

  # get "posts" => "posts#index", as: :posts
  # namespace :api do
  #   namespace :v1 do
  #     resources :posts, only: [:index, :show, :create, :update, :destroy]
  # ``

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
