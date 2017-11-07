class CommentsController < ApplicationController
before_action :find_commentable
before_action :authenticate_user!

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user = current_user
      if @comment.save
        # create_notification @commentable, @comment
        respond_to do |format|
          format.html do
            redirect_to :back, notice: 'Your comment was successfully posted!'
          end
          format.js
        end
      else
        redirect_to :back, notice: "Your comment wasn't posted!"
      end
    end

    private

    # def create_notification(commentable, comment)
    #   return if commentable.user.id == current_user.id 
    #   Notification.create(user_id: commentable.user.id, notified_by_id: current_user.id, commentable_id: commentable.id, notice_type: 'comment')
    # end



    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Tweet.find_by_id(params[:tweet_id]) if params[:tweet_id]
    end

end
