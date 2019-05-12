class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @title = 'ПОЛЬЗОВАТЕЛИ'
    @subtitle = 'Преподаватели кафедры'
  end

  def show
    @user = User.find(params[:id])
    @title = 'ЛИЧНЫЙ КАБИНЕТ'
  end

  def destroy_all_output_files
    current_user.files_excels.destroy_all
    redirect_to current_user
  end

  def make_admin
    @user = User.find(params[:id])
    @user.update(admin: true)
  end

  def revoke_admin
    @user = User.find(params[:id])
    @user.update(admin: false)
  end

  def update
    #@user.update(user_params)
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = 'OK!'
    redirect_to current_user
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, notice: "Пользователь был удалён."
    else
      redirect_to users_path, flash: { error: "Пользователь не может быть удалён." }
    end

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
  end

end
