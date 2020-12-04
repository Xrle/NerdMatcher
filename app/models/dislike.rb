class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :disliked, class_name: 'User', foreign_key: :disliked_id
end
