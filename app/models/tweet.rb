class Tweet < ApplicationRecord
  mount_uploaders :images, ImageUploader
  # serialize :images, JSON # If you use SQLite, add this line.
  
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :body

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  acts_as_votable

  belongs_to :user
  belongs_to :tweet, optional: true

  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def tweet_type
    if tweet_id? && body?
      "quote-tweet"
    elsif tweet_id?
      "retweet"
    else
      "tweet"
    end
  end
end
