# == Schema Information
# Schema version: 20090920194401
#
# Table name: password_resets
#
#  id         :integer       not null, primary key
#  user_id    :integer       
#  token      :string(255)   
#  email      :string(255)   
#  created_at :datetime      
#  updated_at :datetime      
#

class PasswordReset < ActiveRecord::Base

  TOKEN_SIZE = 8

  belongs_to :user

  def before_create
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    random_string = ""
    1.upto(TOKEN_SIZE) { |i| random_string << chars[rand(chars.size-1)] }
    self.token = random_string
  end

  def validate
    errors.add("Email", "did not match any user") if self.user_id.nil?
  end

end
