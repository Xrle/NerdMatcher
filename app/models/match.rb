class Match < ApplicationRecord
  validates_presence_of :user_id, :matched_id
  validate :does_not_exist_in_reverse

  belongs_to :user
  belongs_to :matched, class_name: 'User', foreign_key: :matched_id

  #Find a match record
  def find_match(user_id, matched_id)
    match = Match.where(user_id: user_id, matched_id: matched_id).first
    #Try with the ids the other way around if not found
    if match == nil
      match = Match.where(user_id: matched_id, matched_id: user_id).first
    end

    #Return match record or nil if not found
    match
  end

  #If A -> B exists in the database, disallow adding B -> A
  def does_not_exist_in_reverse
    if Match.exists?(user_id: matched_id, matched_id: user_id)
      errors.add(:user_id, 'This match exists in reverse!')
    end
  end
end
