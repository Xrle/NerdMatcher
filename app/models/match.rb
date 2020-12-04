class Match < ApplicationRecord
  belongs_to :user
  belongs_to :matched, class_name: 'User', foreign_key: :matched_id
end
