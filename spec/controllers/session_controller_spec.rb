require File.dirname(__FILE__) + '/../spec_helper.rb'

context "/session/new GET" do
  controller_name :sessions

  specify "should render new" do
    get :new
    response.should render_template('new')
  end
end

context "/session POST" do
  controller_name :sessions
  before(:each) do
    @user = mock_user
    User.stub!(:authenticate).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)

    @user.stub!(:remember_me)
    controller.stub!(:cookies).and_return(@ccookies)

    @ccookies.stub!(:[]=)
    @ccookies.stub!(:[])
    @user.stub!(:remember_token).and_return('1111')
    @user.stub!(:remember_token_expires_at).and_return(Time.now)
  end

  specify 'should authenticate user' do
    User.should_receive(:authenticate).with('paul@paul.com', 'password').and_return(@user)
    post :create, :session => {:email => 'paul@paul.com', :password => 'password'}
  end

  specify "should remember me" do
    post :create, :session => {}
    response.cookies["auth_token"].should be_nil
  end

  specify "should redirect to root" do
    post :create, :session => {}
    response.should redirect_to('http://test.host/')
  end
end

context "/session POST with remember me" do
  controller_name :sessions
  before(:each) do
    @user = mock_user

    @ccookies = mock('cookies')
    User.stub!(:authenticate).and_return(@user)
    controller.stub!(:logged_in?).and_return(false, true)
    @user.stub!(:remember_me)
    controller.stub!(:cookies).and_return(@ccookies)

    @ccookies.stub!(:[]=)
    @ccookies.stub!(:[])
    @user.stub!(:remember_token).and_return('1111')
    @user.stub!(:remember_token_expires_at).and_return(Time.now)
  end

  # this never tested correct code, fixtures weren't loading
  # specify "should remember me" do
  #   @user.should_receive(:remember_me)
  #   post :create, :name => "derek", :password => "password", :remember_me => "1"
  # end

  # specify 'should create cookie' do
  #   @ccookies.should_receive(:[]=).with(:auth_token, { :value => '1111' , :expires => @user.remember_token_expires_at })
  #   post :create, :name => "derek", :password => "password", :remember_me => "1"
  # end
end

context "/session POST when invalid" do
  controller_name :sessions
  before(:each) do
    @user = mock_user

    controller.stub!(:logged_in?).and_return(false)
    User.stub!(:authenticate).and_return(nil)
  end

  specify 'should authenticate user' do
    User.should_receive(:authenticate).with('user@user.com', 'password').and_return(nil)
    post :create, :session => {:email => 'user@user.com', :password => 'password'}
  end

  specify "should not remember me" do
    post :create
    response.cookies["auth_token"].should be_nil
  end

  specify "should render new" do
    post :create
    response.should render_template('new')
  end
end

context "/session DELETE" do
  controller_name :sessions
  before(:each) do
    @user = mock_user

    @ccookies = mock('cookies')
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:logged_in?).and_return(true, true)
    @user.stub!(:forget_me)
    controller.stub!(:cookies).and_return(@ccookies)
    @ccookies.stub!(:delete)
    @ccookies.stub!(:[])
    response.cookies.stub!(:delete)
    controller.stub!(:reset_session)
  end

  specify "should get current user" do
    controller.should_receive(:current_user).and_return(@user)
    delete :destroy
  end

  specify 'should forget current user' do
    @user.should_receive(:forget_me)
    delete :destroy
  end

  specify "should delete token on logout" do
    @ccookies.should_receive(:delete).with(:auth_token)
    delete :destroy
  end

  specify 'should reset session' do
    controller.should_receive(:reset_session)
    delete :destroy
  end

  specify "should redirect to root" do
    delete :destroy
    response.should redirect_to('http://test.host/')
  end
end
