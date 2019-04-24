class EducationalAndMethodicalWorksController < ApplicationController
  before_action :set_educational_and_methodical_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def add_educational_and_methodical_work
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    # binding.pry
    @temp.educational_and_methodical_works = params[:quantity_hash_em].to_unsafe_h
    @temp.save
  end

  def index
    @educational_and_methodical_works = EducationalAndMethodicalWork.all
    respond_with(@educational_and_methodical_works)
  end

  def show
    respond_with(@educational_and_methodical_work)
  end

  def new
    @educational_and_methodical_work = EducationalAndMethodicalWork.new
    respond_with(@educational_and_methodical_work)
  end

  def edit
  end

  def create
    @educational_and_methodical_work = EducationalAndMethodicalWork.new(educational_and_methodical_work_params)
    @educational_and_methodical_work.save
    respond_with(@educational_and_methodical_work)
  end

  def update
    @educational_and_methodical_work.update(educational_and_methodical_work_params)
    respond_with(@educational_and_methodical_work)
  end

  def destroy
    @educational_and_methodical_work.destroy
    respond_with(@educational_and_methodical_work)
  end

  private
    def set_educational_and_methodical_work
      @educational_and_methodical_work = EducationalAndMethodicalWork.find(params[:id])
    end

    def educational_and_methodical_work_params
      # params[:educational_and_methodical_work]
      params.require(:educational_and_methodical_work).permit(:work_name, :time_rate, :note)
    end
end
