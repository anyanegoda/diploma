class NameWorksController < ApplicationController
  before_action :set_name_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @name_works = NameWork.all
    respond_with(@name_works)
  end

  def show
    respond_with(@name_work)
  end

  def new
    @name_work = NameWork.new
    respond_with(@name_work)
  end

  def edit
  end

  def create
    @name_work = NameWork.new(name_work_params)
    @name_work.save
    respond_with(@name_work)
  end

  def update
    @name_work.update(name_work_params)
    respond_with(@name_work)
  end

  def destroy
    @name_work.destroy
    respond_with(@name_work)
  end

  private
    def set_name_work
      @name_work = NameWork.find(params[:id])
    end

    def name_work_params
      params.require(:name_work).permit(:name)
    end
end
