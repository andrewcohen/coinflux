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

class Trade < ActiveRecord::Base
  belongs_to :wallet

  validates_inclusion_of :transaction_type, in: ["buy", "sell"]

  scope :pending, -> {where("completed_at is null")}
  scope :unconfirmed, -> {where("confirmed_at is null")}

  def status
    if confirmed_at? && completed_at?
      "COMPLETED"
    elsif confirmed_at?
      "PENDING"
    else
      "UNCONFIRMED"
    end
  end
end

