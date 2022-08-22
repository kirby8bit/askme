class ApplicationController < ActionController::Base
  helper_method :current_user, :current_color
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_color
    if current_user.nil?
      '#370617'
    else
      current_user.color
    end
  end
end
