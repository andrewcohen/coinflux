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
  validates_numericality_of :buy_amount, allow_nil: true, greater_than_or_equal_to: 0
  validates_numericality_of :sell_amount, allow_nil: true, greater_than_or_equal_to: 0

  scope :pending, -> {where("completed_at is null")}
  scope :unconfirmed, -> {where("confirmed_at is null")}

  before_save :convert_values

  def buy_amount=(amt)
    write_attribute(:buy_amount, amt) unless confirmed_at?
  end

  def sell_amount=(amt)
    write_attribute(:sell_amount, amt) unless confirmed_at?
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

  def confirm!
    unless self.confirmed_at?
      self.update_attributes(confirmed_at: Time.now.utc)
    else
      self.errors.add(:base, "Trade is already confirmed!")
      false
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
        end_btc = btc_funds + self.buy_amount
        end_cash = cash_funds - price_of_desired_btc
        attrs = {
          start_btc: btc_funds,
          start_cash: cash_funds,
          end_btc: end_btc,
          end_cash: end_cash,
          completed_at: Time.now
        }
        self.update_attributes(attrs)

        # update wallet
        self.wallet.update_attributes(btc_value: end_btc, cash_value: end_cash)
      else
        # reject trade
        errors.add(:base, "NOT ENOUGH FUNDS!")
      end
    else

    end
  end

  private

  def convert_values
    unless confirmed_at?
      if self.buy_amount && (new_record? || buy_amount_changed?)
        self.buy_amount = (self.buy_amount.to_f * 100000).to_i
      end

      if self.sell_amount && (new_record? || sell_amount_changed?)
        self.sell_amount = (self.sell_amount.to_f * 100000).to_i
      end
    end
  end
end

