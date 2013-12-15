# == Schema Information
#
# Table name: depth_tickers
#
#  id           :integer          not null, primary key
#  price        :integer
#  volume       :integer
#  type_num     :integer
#  type_str     :string(255)
#  item         :string(255)
#  currency     :string(255)
#  total_volume :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :depth_ticker do
    price 1
    volume 1
    type_num 1
    type_str "MyString"
    item "MyString"
    currency "MyString"
    total_volume_int 1
  end
end
