class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :get_latest_price

  private

  def get_latest_price
    latest = TickerPrice.last
    @latest_price = {}
    @latest_price[:buy] = latest.buy
    @latest_price[:sell] = latest.sell
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access."
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
