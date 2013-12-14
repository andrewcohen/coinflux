# == Schema Information
#
# Table name: ticker_prices
#
#  id         :integer          not null, primary key
#  high       :integer
#  low        :integer
#  avg        :integer
#  vwap       :integer
#  last_local :integer
#  last_orig  :integer
#  last       :integer
#  buy        :integer
#  sell       :integer
#  date       :datetime
#  created_at :datetime
#  updated_at :datetime
#

class TickerPrice < ActiveRecord::Base

  def actual_price(price)
    price.to_f / 100000
  end

  def graph_data_for(attr)
    {x: self.created_at.to_i, y: actual_price(attr)}
  end

  def graph_buy_price
    graph_data_for(self.buy)
  end

  def graph_sell_price
    graph_data_for(self.sell)
  end
end
