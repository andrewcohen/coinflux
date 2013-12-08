class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
