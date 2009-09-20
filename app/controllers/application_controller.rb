# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable

  class AccessDenied < StandardError; end

  # Pick a unique cookie name to distinguish our session data from others'
  # session :session_key => '_trunk_session_id'

  #before_filter :login_required

  around_filter :catch_errors

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2f17755d2b7b4e8e3dd03cef619dd505'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  before_filter :set_facebook_session
  before_filter :save_facebook_session
  helper_method :facebook_session

  protected
    def self.protected_actions
      [ :edit, :update, :destroy ]
    end
    
    def save_facebook_session
      if facebook_session and !facebook_session.expired?
        f = FacebookSession.find_or_initialize_by_uid(facebook_session.uid)
        f.session = facebook_session
        f.session_key = facebook_session.session_key
        f.user = current_user if logged_in?
        f.save
      end
    end
    
    def login_user(user)
      self.current_user = user
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token,
                               :expires => self.current_user.remember_token_expires_at}
    end

  private

    def catch_errors
      begin
        yield

      rescue AccessDenied
        flash[:notice] = "You do not have access to that area."
        redirect_to '/'
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Sorry, can't find that record."
        redirect_to '/'
      end
    end

end
