Coinflux::Application.routes.draw do
  root to: "home#index"
  resources :ticker_prices
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :wallets
end
