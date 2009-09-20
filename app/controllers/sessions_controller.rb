# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  layout "1col"

  def new
  end

  def create
    if params[:session]
      user = User.authenticate(params[:session][:email], params[:session][:password])
    end
    if user
      login_user(user)
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Can't find User or Password doens't match"
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
