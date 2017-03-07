class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :store_current_location, unless: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    session[:redirect_after_log_in] || root_path
  end

  def after_sign_up_path_for(resource)
    session[:redirect_after_log_in] || root_path
  end

  def store_current_location
    session[:redirect_after_log_in] = request.env['PATH_INFO']
  end

end
