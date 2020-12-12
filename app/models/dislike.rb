class Dislike < ApplicationRecord
  validates_presence_of :user_id, :disliked_id

  belongs_to :user
  belongs_to :disliked, class_name: 'User', foreign_key: :disliked_id
end
