require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do

  def mock_password_reset(stubs={})
    @mock_password_reset ||= mock_model(PasswordReset, stubs)
  end

  before(:each) do
    mock_password_reset.stub!(:email).and_return("paul@paul.com")
    mock_password_reset.stub!(:token).and_return("atoken")
    @user = mock_user
    mock_password_reset.stub!("user=")
    mock_password_reset.stub!("user").and_return(mock_user)
    user = mock_password_reset.stub!(:user).and_return(mock_user)
    @user.stub!(:remember_me)
    controller.stub!(:current_user).and_return(@user)
  end

  describe "responding to GET new" do

    it "should expose a new password_reset as @password_reset" do
      PasswordReset.should_receive(:new).and_return(mock_password_reset)
      get :new
      assigns[:password_reset].should equal(mock_password_reset)
    end

  end

  describe "responding to GET edit" do

    before(:each) do
      @user = mock_user
      controller.stub!(:current_user).and_return(@user)
      @user.stub!(:remember_token).and_return('1111')
      @user.stub!(:remember_token_expires_at).and_return(Time.now)
      @user.stub!(:remember_me).and_return(true)
    end

    it "should expose the requested password_reset as @password_reset" do
      PasswordReset.should_receive(:find_by_token).with("atoken").and_return(mock_password_reset)
      get :edit, :token => "atoken"
      assigns[:password_reset].should equal(mock_password_reset)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do

      it "should expose a newly created password_reset as @password_reset" do
        mock_password_reset.stub!("save").and_return(true)
        PasswordReset.should_receive(:new).with({'email' => 'paul@paul.com'}).and_return(mock_password_reset(:save => true))
        post :create, :password_reset => {:email => 'paul@paul.com'}
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should redirect to the created password_reset" do
        mock_password_reset.stub!("save").and_return(true)
        PasswordReset.stub!(:new).and_return(mock_password_reset(:save => true))
        post :create, :password_reset => {}
        response.should render_template('create')
      end

    end

    describe "with invalid params" do

      it "should expose a newly created but unsaved password_reset as @password_reset" do
        mock_password_reset.stub!("save").and_return(false)
        PasswordReset.stub!(:new).with({'email' => 'paul'}).and_return(mock_password_reset(:save => false))
        post :create, :password_reset => {:email => 'paul'}
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should re-render the 'new' template" do
        mock_password_reset.stub!("save").and_return(false)
        PasswordReset.stub!(:new).and_return(mock_password_reset(:save => false))
        post :create, :password_reset => {}
        response.should render_template('new')
      end

    end

  end

  describe "responding to PUT update" do

    describe "with valid params" do

      before(:each) do
        @user = mock_password_reset.user
        @mock_password_reset.stub!(:destroy)
        @user.stub!(:update_attributes)
      end

      it "should update the requested user" do
        PasswordReset.should_receive(:find_by_token).with("atoken").and_return(mock_password_reset)
        @user.should_receive(:update_attributes).with({'password' => 'paul', 'password_confirmation' => 'paul'}).and_return(true)
        put :update, :token => "atoken", :user => {'password' => 'paul', 'password_confirmation' => 'paul'}
      end

      it "should destroy the password reset" do
        PasswordReset.should_receive(:find_by_token).with("atoken").and_return(mock_password_reset)
        @user.should_receive(:update_attributes).and_return(true)
        @mock_password_reset.should_receive(:destroy)
        put :update, :token => "atoken", :user => {'password' => 'paul', 'password_confirmation' => 'paul'}
      end

      it "should expose the requested password_reset as @password_reset" do
        PasswordReset.stub!(:find_by_token).and_return(mock_password_reset(:update_attributes => true))
        @user.should_receive(:update_attributes).and_return(true)
        put :update, :token => "atoken"
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should redirect to the user" do
        PasswordReset.stub!(:find_by_token).and_return(mock_password_reset(:update_attributes => true))
        @user.should_receive(:update_attributes).and_return(true)
        put :update, :token => "atoken"
        response.should redirect_to(user_url(mock_user))
      end

    end

    describe "with invalid params" do

      before(:each) do
        @user = mock_password_reset.user
        @mock_password_reset.stub!(:destroy)
        @user.stub!(:update_attributes).and_return(false)
      end

      it "should expose the password_reset as @password_reset" do
        PasswordReset.stub!(:find_by_token).and_return(mock_password_reset(:update_attributes => false))
        put :update, :token => "atoken"
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should re-render the 'edit' template" do
        PasswordReset.stub!(:find).and_return(mock_password_reset(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

end
