class ColorsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:session)
    session[:color] = user_params[:color]
    redirect_to questions_path, notice: 'Цвет шапки изменен !'
  end
end
