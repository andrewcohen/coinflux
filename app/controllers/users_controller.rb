class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up."
    else
      flash[:error] = @user.errors.full_messages.join
      redirect_to :back
    end
  end

  def edit
  end

  def update
  end

private
  def user_params
    params.require(:user).permit(:username,
     :password, :password_confirmation
    )
  end
end
