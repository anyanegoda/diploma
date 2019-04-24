class ResearchWorksController < ApplicationController
  before_action :set_research_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def add_research_work
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    # binding.pry
    @temp.research_works = params[:quantity_hash].to_unsafe_h
    @temp.save
  end

  def index
    @research_works = ResearchWork.all
    respond_with(@research_works)
  end

  def show
    respond_with(@research_work)
  end

  def new
    @research_work = ResearchWork.new
    respond_with(@research_work)
  end

  def edit
  end

  def create
    @research_work = ResearchWork.new(research_work_params)
    @research_work.save
    respond_with(@research_work)
  end

  def update
    @research_work.update(research_work_params)
    respond_with(@research_work)
  end

  def destroy
    @research_work.destroy
    respond_with(@research_work)
  end

  private
    def set_research_work
      @research_work = ResearchWork.find(params[:id])
    end

    def research_work_params
      # params[:research_work]
      params.require(:research_work).permit(:work_name, :time_rate, :note)

    end
end
