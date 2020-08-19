Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'users/logout_path', to: 'users#logout'
  resources :users, only: [:show]
  resources :credit_cards, only: :new
  resources :items, only: [:index, :show, :new] do
    collection do
      get 'search'
    end
  end
  resources :purchases, only: :new
end
