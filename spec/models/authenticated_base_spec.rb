require File.dirname(__FILE__) + '/../spec_helper'

context "A User abstract class" do
  include ActiveRecordMatchers

  specify "should have valid associations" do
    User.new.should have_valid_associations
  end

end

context "An existing user" do
  before(:each) do
    @user = User.create!(:name => 'quentin', :password => 'monkey', :password_confirmation => 'monkey', :email => 'test@foo.bar')
    @store.stub!(:buyers).and_return(User)
  end
  
  specify "should authenticate with new or reset password" do
    @user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    User.authenticate('test@foo.bar', 'new password').should == @user
  end
  
  specify "should not rehash password on name change" do
    @user.update_attributes(:email => 'test@foo.bar')
    User.authenticate('test@foo.bar', 'monkey').should == @user
  end
  
  specify "should remember token" do
    @user.should_not be_remember_token
    lambda{ @user.remember_me }.should change( @user, :remember_token ).from(nil)
    @user.remember_token_expires_at.should_not be_nil
    @user.should be_remember_token
  end
  
  specify "should increment hit counter" do
    lambda{ @user.remember_me }.should change( @user, :visits_count ).from(0).to(1)
  end
  
  specify "should forget token" do
    lambda{ @user.remember_me }.should change( @user, :remember_token ).from(nil)
    @user.should be_remember_token

    lambda{ @user.forget_me   }.should change( @user, :remember_token ).to(nil)
    @user.should_not be_remember_token
  end

  specify "should be remembered for a period" do
    before = 1.week.from_now.utc
    lambda{ @user.remember_me_for 1.week }.should change(@user, :remember_token).from(nil)
    after = 1.week.from_now.utc
    @user.remember_token_expires_at.should be_between(before,after)
  end
end

# http://rashkovskii.com/files/user_spec.rb
context "A new user" do

  specify "should create" do
    lambda{ user = create_user ; user.should_not be_new_record }.should change(User,:count).by(1)
  end
    
  specify "should require password" do
    lambda{ u = create_user(:password => nil) ; u.should have_at_least(1).errors_on(:password)}.
          should_not change(User,:count)
  end

  specify "should require email" do
    lambda{ u = create_user(:email => nil) ; u.should have_at_least(1).errors_on(:email)}.
          should_not change(User,:count)
  end

  def create_user(options = {})
    User.create({ :name => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end
