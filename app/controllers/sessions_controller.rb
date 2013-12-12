class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in!"
      redirect_to root_url
    else
      flash[:error] = "Email or password is invalid."
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
      flash[:success] = "Logged out!"
    redirect_to root_url
  end

end
