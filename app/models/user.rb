class User < ApplicationRecord
	extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	attr_accessor :login

  has_many :tweets, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  # has_many :notifications, dependent: :destroy

  # Returns a user's status feed with only people they follow.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.search(search)
    where("name LIKE ? OR username LIKE ?", "%#{search}%", "%#{search}%") 
  end

  def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    if conditions[:username].nil?
	      where(conditions).first
	    else
	      where(username: conditions[:username]).first
	    end
	  end
	end
end
