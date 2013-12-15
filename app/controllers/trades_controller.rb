class TradesController < ApplicationController
  before_filter :require_login
  before_filter :current_wallet

  def new
    @trade = Trade.new
  end

  def create
    @trade = current_wallet.trades.build(trade_params)

    if @trade.save
      flash[:success] = "Trade created"
      redirect_to confirm_wallet_trade_path(current_wallet, @trade)
    else
      flash[:error] = @trade.errors.full_messages.join(", ")
      redirect_to :back
    end
  end

  def confirm
    @trade = current_wallet.trades.where(id: params[:id]).first
  end

  def confirm_trade
    @trade = current_wallet.trades.where(id: params[:id]).first

    attrs = {
      start_btc: current_wallet.btc_value,
      start_cash: current_wallet.cash_value,
      confirmed_at: Time.now.utc
    }

    if @trade.update_attributes(attrs)
      flash[:success] = "Trade confirmed"
      redirect_to wallet_trade_path(current_wallet, @trade)
    else
      flash[:error] = "Something went wrong"
      redirect_to :back
    end
  end

  def show
    @trade = current_wallet.trades.where(id: params[:id]).first
  end

  private

  def current_wallet
    @wallet ||= current_user.wallets.where(id: params[:wallet_id]).first
  end

  def trade_params
    params.require(:trade).permit(:transaction_type, :buy_amount, :sell_amount)
  end
end
