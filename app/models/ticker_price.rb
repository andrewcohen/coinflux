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
end
