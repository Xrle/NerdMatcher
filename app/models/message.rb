class Message < ApplicationRecord
  validates_presence_of :user_id, :target_id, :content
  belongs_to :user
  belongs_to :target, class_name: 'User', foreign_key: :target_id
end
