Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'users/logout_path', to: 'users#logout'
  resources :users, only: [:show]
  resources :items, only: [:index, :show, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :purchases, only: :new
  resources :credit_cards, only: [:new,:show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end
