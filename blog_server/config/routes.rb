Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # rote to get all the posts
  namespace :v1 do
    resources :posts, only: [ :index, :show, :update, :destroy ]
    resources :users, only: [ :index, :show, :create, :update ]
    # resources :likes, only: [ :index, :show, :create, :update, :destroy ]
    resources :comments, only: [ :index, :update, :destroy ]
    resources :categories, only: [ :index, :create, :update, :destroy ]

    resources :users do
      resources :comments, only: [ :index ]
      resources :posts, only: [ :index, :create ]
      resources :likes, only: [ :index ]
    end

    resources :categories do
      resources :posts, only: [ :index ]
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
