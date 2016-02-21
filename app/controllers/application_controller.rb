class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_authentication

  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
  end

  def require_authentication
    unless current_user
      flash[:error] = "You must be logged in!"
      redirect_to root_url
    end
  end
end
