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

class DepthTicker < ActiveRecord::Base
end
