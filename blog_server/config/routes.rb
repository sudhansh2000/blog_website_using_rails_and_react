Rails.application.routes.draw do
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
    resources :categories, only: [ :index, :show, :create, :update, :destroy ]

    resources :users do
      resources :comments, only: [ :index ]
      resources :posts, only: [ :index, :show, :create, :destroy ]
      resources :likes, only: [ :index ]
    end
    resources :categories do
      resources :posts, only: [ :index, :create ]
    end
    resources :posts do
      resources :comments, only: [ :index, :create ]
      resources :likes, only: [ :index, :create ]
    end
    resources :comments do
      resources :comments, only: [ :index, :create ]
      resources :likes, only: [ :index, :create ]
    end
  end
end
