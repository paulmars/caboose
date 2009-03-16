require File.dirname(__FILE__) + '/../spec_helper'

context "A User" do
  include ActiveRecordMatchers

  before(:each) do
   @user = User.new :name => 'quentin', :password => 'blah', :password_confirmation => 'blah', :email => 'quentin@example.com'
  end

  specify "should have valid associations" do
     @user.save!
     @user.should have_valid_associations
  end

  specify "should protect against updates to secure attributes" do
    @user.save
    lambda{ 
      @user.update_attributes(:created_at => 3)
    }.should_not change(@user, :created_at)
  end
  
end

