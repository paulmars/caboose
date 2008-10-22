require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do
  describe "route generation" do
    it "should map #new" do
      route_for(:controller => "password_resets", :action => "new").should == "/password_reset/new"
    end
  
    it "should map #edit" do
      route_for(:controller => "password_resets", :action => "edit", :token => "atoken").should == "/password_reset/edit?token=atoken"
    end
  
    it "should map #update" do
      route_for(:controller => "password_resets", :action => "update", :token => "atoken").should == "/password_reset?token=atoken"
    end
  end

  describe "route recognition" do
    it "should generate params for #new" do
      params_from(:get, "/password_reset/new").should == {:controller => "password_resets", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/password_reset").should == {:controller => "password_resets", :action => "create"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/password_reset/edit").should == {:controller => "password_resets", :action => "edit"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/password_reset").should == {:controller => "password_resets", :action => "update"}
    end
  end
end
