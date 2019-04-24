class EducationalWorksController < ApplicationController
  before_action :set_educational_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def add_educational_work
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    # binding.pry
    @temp.educational_works = params[:quantity_hash].to_unsafe_h
    @temp.save
  end

  def index
    @educational_works = EducationalWork.all
    respond_with(@educational_works)
  end

  def show
    respond_with(@educational_work)
  end

  def new
    @educational_work = EducationalWork.new
    respond_with(@educational_work)
  end

  def edit
  end

  def create
    @educational_work = EducationalWork.new(educational_work_params)
    @educational_work.save
    respond_with(@educational_work)
  end

  def update
    @educational_work.update(educational_work_params)
    respond_with(@educational_work)
  end

  def destroy
    @educational_work.destroy
    respond_with(@educational_work)
  end

  private
    def set_educational_work
      @educational_work = EducationalWork.find(params[:id])
    end

    def educational_work_params
      # params[:educational_work]
      params.require(:educational_work).permit(:work_name, :time_rate, :note)
    end
end
