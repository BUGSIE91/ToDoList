class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  # Checks if a user has logged in to the system
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Will allow form navigations and task modifications only if the user is authorized to do that particular action
  def require_user
    redirect_to '/login' unless current_user
  end
end
