# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable

  class AccessDenied < StandardError; end

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_trunk_session_id'

  # If you want timezones per-user, uncomment this:
  #before_filter :login_required

  around_filter :set_timezone
  around_filter :catch_errors
  
  protected
    def self.protected_actions
      [ :edit, :update, :destroy ]
    end

  private

    def set_timezone
      TzTime.zone = logged_in? ? current_user.tz : TimeZone.new('Etc/UTC')
        yield
      TzTime.reset!
    end

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
