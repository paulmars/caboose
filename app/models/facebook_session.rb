# == Schema Information
# Schema version: 20090920194401
#
# Table name: facebook_sessions
#
#  id          :integer       not null, primary key
#  user_id     :integer       
#  uid         :integer       
#  session_key :string(255)   
#  created_at  :datetime      
#  updated_at  :datetime      
#

class FacebookSession < ActiveRecord::Base

  attr_accessor :session

  belongs_to :user
  
  def before_save
    if self.user.nil?
      u = User.new(:name => self.session.user.name)
      u.save_with_validation false
      self.user ||= u
    end
    puts "woah"
  end
  
end
