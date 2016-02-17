Rails.application.routes.draw do
  # Resources
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts
  resources :post_comments
  resources :sub_comments

  match '/help',    to: 'home#help',            via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  root to: 'home#index'
end
