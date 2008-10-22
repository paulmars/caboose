require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do

  def mock_password_reset(stubs={})
    @mock_password_reset ||= mock_model(PasswordReset, stubs)
  end

  describe "responding to GET index" do

    it "should expose all password_resets as @password_resets" do
      PasswordReset.should_receive(:find).with(:all).and_return([mock_password_reset])
      get :index
      assigns[:password_resets].should == [mock_password_reset]
    end

    describe "with mime type of xml" do

      it "should render all password_resets as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PasswordReset.should_receive(:find).with(:all).and_return(password_resets = mock("Array of PasswordResets"))
        password_resets.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET show" do

    it "should expose the requested password_reset as @password_reset" do
      PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
      get :show, :id => "37"
      assigns[:password_reset].should equal(mock_password_reset)
    end

    describe "with mime type of xml" do

      it "should render the requested password_reset as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
        mock_password_reset.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET new" do

    it "should expose a new password_reset as @password_reset" do
      PasswordReset.should_receive(:new).and_return(mock_password_reset)
      get :new
      assigns[:password_reset].should equal(mock_password_reset)
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested password_reset as @password_reset" do
      PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
      get :edit, :id => "37"
      assigns[:password_reset].should equal(mock_password_reset)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do

      it "should expose a newly created password_reset as @password_reset" do
        PasswordReset.should_receive(:new).with({'these' => 'params'}).and_return(mock_password_reset(:save => true))
        post :create, :password_reset => {:these => 'params'}
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should redirect to the created password_reset" do
        PasswordReset.stub!(:new).and_return(mock_password_reset(:save => true))
        post :create, :password_reset => {}
        response.should redirect_to(password_reset_url(mock_password_reset))
      end

    end

    describe "with invalid params" do

      it "should expose a newly created but unsaved password_reset as @password_reset" do
        PasswordReset.stub!(:new).with({'these' => 'params'}).and_return(mock_password_reset(:save => false))
        post :create, :password_reset => {:these => 'params'}
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should re-render the 'new' template" do
        PasswordReset.stub!(:new).and_return(mock_password_reset(:save => false))
        post :create, :password_reset => {}
        response.should render_template('new')
      end

    end

  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested password_reset" do
        PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
        mock_password_reset.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :password_reset => {:these => 'params'}
      end

      it "should expose the requested password_reset as @password_reset" do
        PasswordReset.stub!(:find).and_return(mock_password_reset(:update_attributes => true))
        put :update, :id => "1"
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should redirect to the password_reset" do
        PasswordReset.stub!(:find).and_return(mock_password_reset(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(password_reset_url(mock_password_reset))
      end

    end

    describe "with invalid params" do

      it "should update the requested password_reset" do
        PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
        mock_password_reset.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :password_reset => {:these => 'params'}
      end

      it "should expose the password_reset as @password_reset" do
        PasswordReset.stub!(:find).and_return(mock_password_reset(:update_attributes => false))
        put :update, :id => "1"
        assigns(:password_reset).should equal(mock_password_reset)
      end

      it "should re-render the 'edit' template" do
        PasswordReset.stub!(:find).and_return(mock_password_reset(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested password_reset" do
      PasswordReset.should_receive(:find).with("37").and_return(mock_password_reset)
      mock_password_reset.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "should redirect to the password_resets list" do
      PasswordReset.stub!(:find).and_return(mock_password_reset(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(password_resets_url)
    end

  end

end
