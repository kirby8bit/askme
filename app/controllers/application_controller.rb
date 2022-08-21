class ApplicationController < ActionController::Base
  helper_method :current_user, :current_color
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_color
    if session[:color].present?
      if current_user.nil?
        '#370617'
      else
        current_user.update(color: session[:color])
        current_user.color
      end
    else
      '#370617'
    end
  end
end
