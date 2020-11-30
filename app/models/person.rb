class Person < ApplicationRecord
  #Relationship between a profile and it's user
  has_one :user

  #Likes
  has_many :likes
  has_many :users, through: :likes

  #Dislikes
  has_many :dislikes
  has_many :users, through: :dislikes

  #Matches
  has_many :matches
  has_many :users, through: :matches
end
