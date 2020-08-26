Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  get 'users/logout_path', to: 'users#logout'
  resources :users, only: [:index, :show] do
    collection do
      get 'sold_items'
    end
  end
  resources :credit_cards, only: :new
  resources :items do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'search'
    end
    member do
      get 'purchase', to: 'items#purchase'
      get 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :purchases, only: [:new] do
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
