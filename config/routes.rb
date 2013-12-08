Coinflux::Application.routes.draw do
  root to: "ticker_prices#index"
  resources :ticker_prices
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :wallets
end
