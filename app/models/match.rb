class Match < ApplicationRecord
  validates_presence_of :user_id, :matched_id
  validate :does_not_exist_in_reverse

  belongs_to :user
  belongs_to :matched, class_name: 'User', foreign_key: :matched_id

  #If A -> B exists in the database, disallow adding B -> A
  def does_not_exist_in_reverse
    if Match.exists?(user_id: matched_id, matched_id: user_id)
      errors.add(:match, I18n.t('match.reverse_error'))
    end
  end
end
