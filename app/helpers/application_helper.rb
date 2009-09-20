module ApplicationHelper
  include SemanticFormHelper

  def super_logged_in?
    logged_in? || facebook_logged_in?
  end
  
  def facebook_logged_in?
    facebook_session and !facebook_session.expired?
  end

end
