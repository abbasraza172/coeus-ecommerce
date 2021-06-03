Rails.application.routes.draw do
  root to: 'home#main'
  get '/home/next', to: 'home#next'
  get '/index', to: 'home#index'
  get '/seller', to: 'seller#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
