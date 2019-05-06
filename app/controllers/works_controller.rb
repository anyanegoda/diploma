class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def add_educational_and_methodical_work
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    # binding.pry
    @temp.educational_and_methodical_works = params[:quantity_hash_em].to_unsafe_h
    @temp.save
  end

  def add_research_work
    @temp = User.find(current_user.id)
    @temp.research_works = params[:quantity_hash_r].to_unsafe_h
    @temp.save
  end

  def add_organizational_and_methodical_work
    @temp = User.find(current_user.id)
    @temp.organizational_and_methodical_works = params[:quantity_hash_om].to_unsafe_h
    @temp.save
  end

  def add_educational_work
    @temp = User.find(current_user.id)
    @temp.educational_works = params[:quantity_hash_e].to_unsafe_h
    @temp.save
  end

  def index
    @works = Work.all
    @name_works = NameWork.all
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
    def authorize_work
      authorize @work
    end

    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:work_title, :time_rate, :note, :name_work_id)
    end
end
