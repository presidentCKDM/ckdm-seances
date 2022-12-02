class ApplicationController < ActionController::Base

  class UnauthorizedSession < StandardError ; end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?
  rescue_from UnauthorizedSession, with: :user_not_authorized


  def user_signed_in?
    return false unless session[:user_id]

    current_user
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  end

  def user_not_authorized
    redirect_to new_session_path
  end

  private
    def authenticate_user!
      raise UnauthorizedSession unless user_signed_in?
    end
end
