class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :user
  validates_presence_of :user_id, :image_data
end
