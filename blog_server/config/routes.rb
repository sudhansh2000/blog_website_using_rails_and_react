Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  get "up" => "rails/health#show", as: :rails_health_check

  post "sign_in", to: "v1/sessions#create"
  delete "sign_out", to: "v1/sessions#destroy"
  post "uploads/image", to: "uploads#image"

  namespace :v1 do
    resources :bookmarks, only: [ :destroy ]
    namespace :admin do
      resources :users, only: [ :index, :update, :destroy ] do
        member do
          patch :toggle_active
        end
      end
    end

    resources :users, only: [ :index, :show, :create, :update ] do
      resources :share_posts, only: [ :index, :create ]
      resources :bookmarks, only: [ :index, :create ]
      resources :category_preferences, only: [ :index, :create ]
      resources :comments, only: [ :index ]
      resources :posts, only: [ :index, :create ]
      resources :likes, only: [ :index ]
    end

    resources :categories, only: [ :index, :create, :update, :destroy ] do
      resources :posts, only: [ :index ]
    end

    resources :posts, only: [ :index, :show, :update, :destroy ] do
      resources :comments, only: [ :index, :create ]
      resources :likes, only: [ :index, :create ]
    end

    resources :comments, only: [ :index, :update, :destroy ] do
      resources :comments, only: [ :index, :create ]
      resources :likes, only: [ :index, :create ]
    end
  end
end
