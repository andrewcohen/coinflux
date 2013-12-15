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

    if @trade.update_attributes(confirmed_at: Time.now.utc)
      flash[:success] = "Trade confirmed"

      # TODO move this to a background worker
      @trade.perform! unless @trade.completed_at?

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
