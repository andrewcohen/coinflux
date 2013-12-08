class WalletsController < ApplicationController
  before_filter :require_login

  def index 
    @wallets = current_user.wallets
  end

  def new 
    @wallet = Wallet.new
  end

  def create
    @wallet = current_user.wallets.build(wallet_params)

    if @wallet.save
      redirect_to wallet_path(@wallet), success: "Wallet #{@wallet.name} created!"
    else
      flash[:error] = @wallet.errors.full_messages.join
      redirect_to :back
    end
  
  end

  def show 
    @wallet = Wallet.find(params[:id])
  end

  def edit
    @wallet = Wallet.find(params[:id])
  end

  def update
    @wallet = Wallet.find(params[:id])

    if @wallet.update_attributes(wallet_update_params)
      redirect_to wallet_path(@wallet), success: "Wallet #{@wallet.name} updated"
    else
      flash[:error] = @wallet.errors.full_messages.join
      redirect_to :back
    end
  end

  def destroy
    @wallet = Wallet.find(params[:id])

    if @wallet.destroy
      redirect_to wallets_path, success: "Wallet #{@wallet.name} obliterated" 
    else
      flash[:error] = @wallet.errors.full_messages.join
      redirect_to :back
    end
  end

private
  def wallet_params
    params.require(:wallet).permit(:name, :btc_value, :cash_value)
  end

  def wallet_update_params
    params.require(:wallet).permit(:name)
  end


end