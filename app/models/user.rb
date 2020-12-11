class User < ApplicationRecord
  has_secure_password
  serialize :queue, Array
  enum :gender => [:male, :female, :other]

  #Validations
  validates_uniqueness_of :username
  validates_presence_of :username, :name, :dob, :gender
  validate :dob_before_today?

  def dob_before_today?
    return if dob.blank?
    if dob > Date.today
      errors.add(:dob, 'must be in the past!')
    end
  end

  #Different entry points for the like and dislike joins must be declared as their own associations
  # to prevent name collisions

  has_many :photos

  #Likes
  #has_many :sent_likes, class_name: 'Like', foreign_key: :user_id
  #has_many :received_likes, class_name: 'Like', foreign_key: :liked_id

  #has_many :likes, through: :sent_likes, source: :liked
  #has_many :liked_by, through: :received_likes, source: :user

  has_many :likes, class_name: 'Like', foreign_key: :user_id
  has_many :liked_by, class_name: 'Like', foreign_key: :liked_id


  #Dislikes
  #has_many :sent_dislikes, class_name: 'Dislike', foreign_key: :user_id
  #has_many :received_dislikes, class_name: 'Dislike', foreign_key: :disliked_id

  #has_many :dislikes, through: :sent_dislikes, source: :disliked
  #has_many :disliked_by, through: :received_dislikes, source: :user

  has_many :dislikes, class_name: 'Dislike', foreign_key: :user_id
  has_many :disliked_by, class_name: 'Dislike', foreign_key: :disliked_id

  #Private declarations as should not need to use these associations outside of the model class
  #private :sent_likes, :sent_dislikes, :received_likes, :received_dislikes

  #Matches
  #has_many :sent_matches, class_name: 'Match', foreign_key: :user_id
  #has_many :received_matches, class_name: 'Match', foreign_key: :matched_id

  #has_many :has_matched, through: :sent_matches, source: :matched
  #has_many :matched_by, through: :received_matches, source: :user

  #In matches table, :user_id and :matched_id are interchangeable so this method checks both columns for a match
  def matches
    arr = []
    Match.where('user_id = ? or matched_id = ?', self.id, self.id).each do |m|
      #Match was made by this user
      if m.user_id == self.id
        arr << m.matched_id

      #Match was made by the other user
      else
        arr << m.user_id
      end
    end
    #Return arr
    arr
  end


end
