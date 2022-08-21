class ColorsController < ApplicationController
  def new
  end

  def create
    session_params = params.require(:session)
    session[:color] = session_params[:color]
    redirect_to questions_path, notice: 'Цвет шапки изменен !'
  end
end
