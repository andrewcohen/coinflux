class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_url, flash: { success: "Logged in!" }
    else
      flash[:error] = "Email or password is invalid."
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: "Logged out." }
  end

end
