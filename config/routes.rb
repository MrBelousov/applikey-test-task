Rails.application.routes.draw do
  # Resources
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :posts do
    namespace :posts do
      resources :comments, only: :create
    end
  end

  resources :comments do
    namespace :comments do
      resources :comments, only: :create
    end
  end

  # Static pages
  match '/help',    to: 'home#help',            via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # Facebook authentication
  match 'auth/:provider/callback', to: 'omniauth_sessions#create', via: 'get'
  match 'auth/failure', to: 'omniauth_sessions#oaut_failure', via: 'get'

  # API v1
  namespace :api, defaults: { format: :json } do
    resources :users
    resources :sessions, only: [:new, :create, :destroy]

    resources :posts do
      namespace :posts do
        resources :comments, only: :create
      end
    end

    resources :comments do
      namespace :comments do
        resources :comments, only: :create
      end
    end
  end

  #Root
  root to: 'home#index'
end
