# == Schema Information
# Schema version: 20090920194401
#
# Table name: users
#
#  id                        :integer       not null, primary key
#  name                      :string(255)   
#  email                     :string(255)   
#  crypted_password          :string(40)    
#  salt                      :string(40)    
#  created_at                :datetime      
#  updated_at                :datetime      
#  last_login_at             :datetime      
#  remember_token            :string(255)   
#  remember_token_expires_at :datetime      
#  visits_count              :integer       default(0)
#  permalink                 :string(255)   
#

require 'digest/sha1'
class User < ActiveRecord::Base
  include AuthenticatedBase
  has_many :assets, :as => :attachable
  has_one :password_reset

  validates_uniqueness_of :email, :permalink, :case_sensitive => false

  # Protect internal methods from mass-update.
  attr_accessible :name, :email, :password, :password_confirmation, :time_zone

  def before_create
    self.name ||= self.email.split('@').first.gsub(/W/,'')

    i = 1
    perma_stub = self.name.downcase.gsub(/\W/,'')
    perma_try = perma_stub
    while User.find_by_permalink(perma_try) != nil
      i = i + 1
      perma_try = "#{perma_stub}#{i}"
    end
    self.permalink ||= perma_try
  end

  def to_param
    permalink
  end

  def self.find_by_param(*args)
    find_by_permalink *args
  end

end
