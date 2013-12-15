# == Schema Information
#
# Table name: trades
#
#  id               :integer          not null, primary key
#  wallet_id        :integer
#  buy_amount       :integer
#  sell_amount      :integer
#  start_btc        :integer
#  start_cash       :integer
#  end_btc          :integer
#  end_cash         :integer
#  confirmed_at     :datetime
#  completed_at     :datetime
#  transaction_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade do
    wallet nil
    start_btc 1
    start_cash 1
    end_btc 1
    end_cash 1
    completed_at "2013-12-15 14:38:42"
  end
end
