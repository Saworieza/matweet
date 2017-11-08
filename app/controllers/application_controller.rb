class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user
  # 	@current_user ||= User.find(session[:user_id])if session[:user_id]
  # end
  # helper_method :current_user
  # hide_action :current_user
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :username, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :username, :remember_me])
  end
end
