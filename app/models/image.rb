class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :avatar, PictureUploader

  validates :avatar, presence: true
  validates :imageable_id, presence: true
  validates :imageable_type, presence: true
end
