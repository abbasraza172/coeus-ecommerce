Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root to: 'home#main'
  get '/home/next', to: 'home#next'
  get '/index', to: 'home#index'
  get '/seller', to: 'seller#index'
  resources :categories
  resources :seller_products
  resources :orders

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
