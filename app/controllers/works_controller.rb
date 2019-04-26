class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @works = Work.all
    respond_with(@works)
  end

  def show
    respond_with(@work)
  end

  def new
    @work = Work.new
    respond_with(@work)
  end

  def edit
  end

  def create
    @work = Work.new(work_params)
    @work.save
    respond_with(@work)
  end

  def update
    @work.update(work_params)
    respond_with(@work)
  end

  def destroy
    @work.destroy
    respond_with(@work)
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:work_title, :time_rate, :note, :name_work_id)
    end
end
