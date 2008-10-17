# == Schema Information
# Schema version: 20081004012912
#
# Table name: users
#
#  id                        :integer(4)    not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  last_login_at             :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  visits_count              :integer(4)    default(0)
#  permalink                 :string(255)
#

require 'digest/sha1'
class User < ActiveRecord::Base
  include AuthenticatedBase
  has_many :assets, :as => :attachable

  validates_uniqueness_of :login, :email, :case_sensitive => false

  # Protect internal methods from mass-update.
  attr_accessible :login, :email, :password, :password_confirmation, :time_zone

  def to_param
    login
  end

  def self.find_by_param(*args)
    find_by_login *args
  end

end
