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
