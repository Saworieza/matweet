class HomeController < ApplicationController
	before_action :authenticate_user!
  def index
  	# @tweets = Tweet.order('created_at DESC')
  	@tweet = current_user.tweets.build if signed_in?
    @feed_items = current_user.feed.order('created_at DESC')


  	@hashtags = SimpleHashtag::Hashtag.order('created_at DESC')

  	#Live chat
  	session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end
end
