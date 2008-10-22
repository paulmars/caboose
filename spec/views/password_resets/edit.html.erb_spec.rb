require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_reset/edit.html.erb" do
  include PasswordResetsHelper
  
  before(:each) do
    assigns[:password_reset] = @password_reset = stub_model(PasswordReset,
      :new_record? => false,
      :token => "value for token"
    )
  end

  it "should render edit form" do
    render "/password_resets/edit.html.erb"

    response.should have_tag("form[action=#{password_reset_path}][method=post]")
  end
end


