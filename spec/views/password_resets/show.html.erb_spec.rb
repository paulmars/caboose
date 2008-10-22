require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_resets/show.html.erb" do
  include PasswordResetsHelper
  
  before(:each) do
    assigns[:password_reset] = @password_reset = stub_model(PasswordReset,
      :token => "value for token"
    )
  end

  it "should render attributes in <p>" do
    render "/password_resets/show.html.erb"
    response.should have_text(/value\ for\ token/)
  end
end

