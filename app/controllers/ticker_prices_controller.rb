class TickerPricesController < ApplicationController
  def index
    @prices = TickerPrice.all
    graph_scope = @prices
    @buy_graph_data = graph_scope.map(&:graph_buy_price)
    @sell_graph_data = graph_scope.map(&:graph_sell_price)
  end
end
