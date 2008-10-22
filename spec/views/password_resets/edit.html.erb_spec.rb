require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_resets/edit.html.erb" do
  include PasswordResetsHelper
  
  before(:each) do
    assigns[:password_reset] = @password_reset = stub_model(PasswordReset,
      :new_record? => false,
      :token => "value for token"
    )
  end

  it "should render edit form" do
    render "/password_resets/edit.html.erb"
    
    response.should have_tag("form[action=#{password_reset_path(@password_reset)}][method=post]") do
      with_tag('input#password_reset_token[name=?]', "password_reset[token]")
    end
  end
end


