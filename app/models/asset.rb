# == Schema Information
# Schema version: 20081004012912
#
# Table name: assets
#
#  id              :integer(4)    not null, primary key
#  filename        :string(255)
#  width           :integer(4)
#  height          :integer(4)
#  content_type    :string(255)
#  size            :integer(4)
#  attachable_type :string(255)
#  attachable_id   :integer(4)
#  updated_at      :datetime
#  created_at      :datetime
#  thumbnail       :string(255)
#  parent_id       :integer(4)
#

class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attachment :storage => :file_system,
    :thumbnails => { :bigthumb => '400>', :thumb => '120>', :tiny => '50>' },
    :max_size => 5.megabytes,
    :path_prefix => "public/image_assets"


end
