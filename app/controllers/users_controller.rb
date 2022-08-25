class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy show]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Вы успешно зарегистрировались !'
    else
      flash.now[:alert] = 'Вы ввели неверные данные в форму регистрации !'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
    else
      flash.now[:alert] = 'Не удалось обновить данные пользователя !'
      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален !'
  end

  def show
    @questions = @user.questions
    @question = Question.new(user: @user)
    @questions = @user.questions.order(created_at: :desc)
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
