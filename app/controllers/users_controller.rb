class UsersController < ApplicationController
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Данные пользователя обновлены !'
    else
      flash.now[:alert] = 'Не удалось обновить данные пользователя !'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален !'
  end



  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
