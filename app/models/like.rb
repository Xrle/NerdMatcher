class Like < ApplicationRecord
  validates_presence_of :user_id, :liked_id

  belongs_to :user
  belongs_to :liked, class_name: 'User', foreign_key: :liked_id
end
