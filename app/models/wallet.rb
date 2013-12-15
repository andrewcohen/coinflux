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

class Wallet < ActiveRecord::Base
  belongs_to :user
  has_many :trades
  validates_presence_of :name, :btc_value, :cash_value

  before_create :convert_values

  def convert_values
    self.cash_value = (self.cash_value.to_f * 100000).to_i
    self.btc_value = (self.btc_value.to_f * 100000).to_i
  end
end
