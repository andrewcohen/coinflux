class TickerPricesController < ApplicationController
	def index 
    @prices = TickerPrice.all
  end
end