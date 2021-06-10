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
  get '/admin', to: 'admin#index'
  get "/cart", to: "home#cart"
  get "/products/list_view", to: "products#list_view"
  get "/products/gird_view", to: "products#grid_view"
  resources :categories
  resources :seller_products
  resources :orders
  resources :products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
