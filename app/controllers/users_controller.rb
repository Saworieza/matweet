class UsersController < ApplicationController

  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :following, :followers]
  # before_action :set_user, except: [:index]

  def index
  	@users = User.order('created_at DESC')
    # @users = User.where.not(id: @current_user).order('RANDOM()').paginate(page: params[:page]).limit(100)
    # @suggestions = User.where.not(id: @current_user).paginate(page: params[:page]).order('RANDOM()').limit(3)
    @hashtags = SimpleHashtag::Hashtag.order('created_at DESC').limit(10)

    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end

 

  def show
  	# @user = User.find(params[:id])
    @user = User.friendly.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')

    # @suggestions = User.where.not(id: @current_user).paginate(page: params[:page]).order('RANDOM()').limit(3)
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password,  :about, :location, :website, :avatar, :cover)
  end

  def check_user
    if @user != current_user
      redirect_to root_path
    end
  end

  # def set_user
    # @user = User.friendly.find(params[:id])
    #according to friendly id the params shoulg be id not username
    # @user = User.friendly.find(params[:username])
  # end

end
