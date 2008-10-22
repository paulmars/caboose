class PasswordNote < ActionMailer::Base

  def password_reset(password_reset)
    @recipients  = "#{password_reset.email}"
    @from        = "admin@example.com"
    @sent_on     = Time.now
    @subject     = "Reset your password."
    @body[:url]  = edit_password_reset_url(:token => password_reset.token, :host => DOMAIN)
  end

end
