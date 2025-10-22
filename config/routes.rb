Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show] do
        member do
          get :get_reviews
        end
      end

      resources :orders, only: [:index, :create, :show] do
        member do
          patch :update_status
        end
      end
      # resources :reviews, only: [:create, :index]
      # resources :users, only: [:show, :create, :update]
    end
  end
end
