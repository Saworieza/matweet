class Tweet < ApplicationRecord
  has_attached_file :media, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :media, content_type: /\Aimage\/.*\z/

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
