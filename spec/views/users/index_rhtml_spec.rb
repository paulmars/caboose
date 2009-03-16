require File.dirname(__FILE__) + '/../../spec_helper'

context "/users/index.rhtml" do
  include UsersHelper
  
  before(:each) do
    user_98 = mock_model(User, :id => 98, :name => 'joe')
    user_99 = mock_model(User, :id => 99, :name => 'mary')

    assigns[:users] = [user_98, user_99]
  end

  specify "should render list of users" do
    render "/users/index.rhtml"

  end
end

