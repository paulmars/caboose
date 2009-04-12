require File.dirname(__FILE__) + '/../../spec_helper'

context "/users/edit.html.erb" do
  include UsersHelper
  
  before(:each) do
    @errors = mock("errors")
    @errors.stub!(:count).and_return(0)

    @user = mock_model(User, :errors => @errors, 
      :name => 'Foo', 
      :email => 'foo@test.bar', 
      :password => nil, :password_confirmation => nil)

    assigns[:user] = @user
  end

  specify "should render edit form" do
    render "/users/edit.html.erb"
    response.should have_tag('form', :attributes =>{:action => user_path(@user), :method => 'post'})

  end
end


