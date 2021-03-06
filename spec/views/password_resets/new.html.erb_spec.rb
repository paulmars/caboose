require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_reset/new.html.erb" do
  include PasswordResetsHelper
  
  before(:each) do
    assigns[:password_reset] = stub_model(PasswordReset,
      :new_record? => true,
      :token => "value for token"
    )
  end

  it "should render new form" do
    render "/password_resets/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", password_reset_path) do
      with_tag("input#password_reset_email[name=?]", "password_reset[email]")
    end
  end
end


