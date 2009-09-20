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
