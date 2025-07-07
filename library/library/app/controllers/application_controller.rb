class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
   @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
   redirect_to login_path unless current_user
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
