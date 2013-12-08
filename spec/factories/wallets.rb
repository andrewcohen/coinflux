# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  cash_value :integer
#  btc_value  :integer
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wallet do
    cash_value 1
    btc_value 1
    user nil
  end
end
