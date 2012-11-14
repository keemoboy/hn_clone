class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user

  private

  def set_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
