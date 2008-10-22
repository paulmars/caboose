require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordReset do
  before(:each) do
    @valid_attributes = {
      :user_id => "1",
      :token => "value for token"
    }
  end

  it "should create a new instance given valid attributes" do
    PasswordReset.create!(@valid_attributes)
  end
end
