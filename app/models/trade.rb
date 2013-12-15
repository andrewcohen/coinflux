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

  before_create :convert_values

  def convert_values
    self.buy_amount = (self.buy_amount.to_f * 100000).to_i if self.buy_amount
    self.sell_amount = (self.sell_amount.to_f * 100000).to_i if self.sell_amount
  end

  def status
    if confirmed_at? && completed_at?
      "COMPLETED (#{completed_at})"
    elsif confirmed_at?
      "PENDING (#{confirmed_at})"
    else
      "UNCONFIRMED"
    end
  end

  def perform!
    if transaction_type == "buy"
      btc_funds  = self.wallet.btc_value
      cash_funds = self.wallet.cash_value

      current_price = TickerPrice.last

      price_of_desired_btc = current_price.buy * self.buy_amount / 100000

      if cash_funds >= price_of_desired_btc
        # trade can happen
        attrs = {
          start_btc: btc_funds,
          start_cash: cash_funds,
          end_btc: btc_funds + self.buy_amount,
          end_cash: cash_funds - price_of_desired_btc,
          completed_at: Time.now
        }
        self.update_attributes(attrs)
      else
        # reject trade
        errors.add(:base, "NOT ENOUGH FUNDS!")
      end
    else

    end
  end
end

