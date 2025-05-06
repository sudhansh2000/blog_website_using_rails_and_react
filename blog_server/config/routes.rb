Rails.application.routes.draw do
  get "share_posts/index"
  get "share_posts/create"
  get "bookmarks/index"
  get "bookmarks/create"
  get "category_preferences/index"
  get "category_preferences/create"
  devise_for :users, defaults: { format: :json }
  get "up" => "rails/health#show", as: :rails_health_check
  # rote to get all the posts
  post "sign_in", to: "v1/sessions#create"
  delete "sign_out", to: "v1/sessions#destroy"

  namespace :v1 do
    resources :posts, only: [ :index, :show, :update, :destroy ]
    resources :users, only: [ :index, :show, :create, :update ]
    # resources :likes, only: [ :index, :show, :create, :update, :destroy ]
    resources :comments, only: [ :index, :update, :destroy ]
    resources :categories, only: [ :index, :create, :update, :destroy ]
    resources :bookmarks, only: [ :destroy ]

    resources :users do
      resources :share_posts, only: [ :index, :create ]
      resources :bookmarks, only: [ :index, :create ]
      resources :category_preferences, only: [ :index, :create ]
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
