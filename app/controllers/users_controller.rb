class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def add_educational_and_methodical_works
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    binding.pry
    @temp.educational_and_methodical_works = params[:quantity_hash]#.to_unsafe_h
    @temp.save
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  def update
    #@user.update(user_params)
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = 'OK!'
    redirect_to root_path
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)  
  end

end
