class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :name
  serialize :queue, Array

  #Relationship between a user and their profile
  belongs_to :person

  #Likes
  has_many :likes
  has_many :people, through: :likes

  #Dislikes
  has_many :dislikes
  has_many :people, through: :dislikes

  #Matches
  has_many :matches
  has_many :people, through: :matches
end
