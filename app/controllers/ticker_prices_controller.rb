class TickerPricesController < ApplicationController
  def index
    @prices = TickerPrice.order("created_at asc").to_a
    @buy_graph_data = @prices.map(&:graph_buy_price)
    @sell_graph_data = @prices.map(&:graph_sell_price)
  end
end
