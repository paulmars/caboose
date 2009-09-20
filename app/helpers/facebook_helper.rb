module FacebookHelper
  
  def current_user_name
    fb_name facebook_session.user.uid, {:linked => false, :useyou => false}
  end
  
end
