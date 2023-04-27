Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :sessions, only: :create, path: :sign_in
      
      resources :users do
        member do
          post :follow
          post :unfollow
          get :share
        end

        collection do
          get :followees
          get :followers

          post :sign_up
        end
      end

      resources :posts do
        resources :comments
      end

      get :search, to: 'users#search'
    end
  end

  get '/s/:slug', to: 'shortended_urls#show', as: :short
end
