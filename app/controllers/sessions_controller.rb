class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "You have successfully logged in"
      redirect_to root_url
    else
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end

  def delete
    sign_out
    flash[:success] = 'You have successfully logged out'
    redirect_to root_url
  end
end
