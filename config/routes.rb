Rails.application.routes.draw do
  # Resources
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments, only: :create
  end
  resources :comments do
    resources :comments, only: :create
  end

  # Static pages
  match '/help',    to: 'home#help',            via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'


  #Root
  root to: 'home#index'
end
