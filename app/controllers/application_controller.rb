class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :signed_in?, :current_user

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def authenticate!
    if !signed_in?
      if request.xhr?
        render :json => {redirect: login_path}
      else
        redirect_to login_path
      end
    end
  end

  def load_and_authorize_user
    @user = User.find_by_name_slug(params[:id])
    redirect_to root_path unless @user.authorize_user(current_user)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


  # This should work for a 404
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
