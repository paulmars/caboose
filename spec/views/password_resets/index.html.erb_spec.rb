require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_resets/index.html.erb" do
  include PasswordResetsHelper
  
  before(:each) do
    assigns[:password_resets] = [
      stub_model(PasswordReset,
        :token => "value for token"
      ),
      stub_model(PasswordReset,
        :token => "value for token"
      )
    ]
  end

  it "should render list of password_resets" do
    render "/password_resets/index.html.erb"
    response.should have_tag("tr>td", "value for token", 2)
  end
end

