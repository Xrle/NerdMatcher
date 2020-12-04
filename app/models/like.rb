class Like < ApplicationRecord
  belongs_to :user
  belongs_to :liked, class_name: 'User', foreign_key: :liked_id
end
