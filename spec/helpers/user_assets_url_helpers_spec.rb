require File.dirname(__FILE__) + '/../spec_helper'

context "the generated url helpers for UserAssetsController" do
  # We include the very same methods that the UserAssetsController
  # makes available to its views.  Note that the helpers we are 
  # testing simply direct the call to the controller - we wire
  # those methods up inside setup().
  include UserAssetsController.master_helper_module

  before(:each) do
    # url helper inferences rely on a correctly named instance variable
    # in the controller
    @user = mock_model(User, :to_param => 'joe')
    assigns[:user] = @user
    assigns[:user_id] = "a"

    @asset = mock_model(Asset, :to_param => '1')
    
    # wire up the fake controller class to use the same helper definition
    # that the real controller uses
  end
  
  specify "should return assets path given no arguments" do
    # todo: user_user_assets_path.should eql("/users/joe/assets")
  end
  
  specify "should return assets path given explicit argument" do
    user_user_assets_path(mock_model(User, :to_param => 'barney')).should eql("/users/barney/assets")
  end

  specify "should return asset path" do
    # todo: asset_path(@asset).should eql("/users/joe/assets/1")
  end
  
  specify "should return edit_asset path" do
    # todo: edit_asset_path(@asset).should eql("/users/joe/assets/1/edit")
  end

  specify "should return new_asset path" do
    #todo: new_user_user_asset_path().should eql("/users/joe/assets/new")
  end

  specify "should return asset_attachable path" do
    user_path(@user).should eql("/users/joe")
  end
end