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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticker_price do
    high 1
    low 1
    avg 1
    vwap 1
    last_local 1
    last_orig 1
    last 1
    buy 1
    sell 1
  end
end
