# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  layout "1col"

  def new
  end

  def create
    if params[:session]
      self.current_user = User.authenticate(params[:session][:login], params[:session][:password])
    end
    if logged_in?
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token,
                               :expires => self.current_user.remember_token_expires_at }
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
