Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'logout', to: 'users#logout'
  resources :items, only: [:index, :new]
  resources :users, only: [:show]
  resources :credit_cards, only: :new
end
