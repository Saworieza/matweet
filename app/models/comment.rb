class Comment < ApplicationRecord
	# include PublicActivity::Model
	# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
	include PublicActivity::Common

  belongs_to :user
  belongs_to :tweet

  has_many :notifications, dependent: :destroy
end
