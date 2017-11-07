class MessagesController < ApplicationController
  before_action :authenticate_user!																																																			
  def index
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end

  # NO longer needed
  # def create
  #   @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
  #   @message = @conversation.messages.create(message_params)
 
  #   respond_to do |format|
  #     format.js
  #   end
  # end
 
  private
 
  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
