Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'users/logout_path', to: 'users#logout'
  resources :users, only: [:show]
  resources :credit_cards, only: :new
  resources :items, only: [:index, :show, :new] do
    resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :purchases, only: [:new,:only] do
    collection do
      get 'index', to: 'purchases#index'
      post 'pay', to: 'purchases#pay'
      get 'done', to: 'purchases#done'
    end
  end
  
  resources :credit_cards, only: [:new,:show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end
end
