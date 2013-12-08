Coinflux::Application.routes.draw do
  root to: "ticker_prices#index"
  resources :ticker_prices 
end
