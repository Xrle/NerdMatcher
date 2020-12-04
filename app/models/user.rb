class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username
  serialize :queue, Array

  #Different entry points for the like and dislike joins must be declared as their own associations
  # to prevent name collisions

  #Likes
  has_many :sent_likes, class_name: 'Like', foreign_key: :user_id
  has_many :received_likes, class_name: 'Like', foreign_key: :liked_id

  has_many :likes, through: :sent_likes, source: :liked
  has_many :liked_by, through: :received_likes, source: :user


  #Dislikes
  has_many :sent_dislikes, class_name: 'Dislike', foreign_key: :user_id
  has_many :received_dislikes, class_name: 'Dislike', foreign_key: :disliked_id

  has_many :dislikes, through: :sent_dislikes, source: :disliked
  has_many :disliked_by, through: :received_dislikes, source: :user

  #Matches
  #has_many :matches
  #has_many :matched_by, through: :matches



end
