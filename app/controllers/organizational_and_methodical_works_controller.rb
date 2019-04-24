class OrganizationalAndMethodicalWorksController < ApplicationController
  before_action :set_organizational_and_methodical_work, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def add_organizational_and_methodical_work
    @temp = User.find(current_user.id)
    # @quantity_hash = params[:quantity_hash]
    # @quantity_hash.permit(:c)
    # binding.pry
    @temp.organizational_and_methodical_works = params[:quantity_hash].to_unsafe_h
    @temp.save
  end

  def index
    @organizational_and_methodical_works = OrganizationalAndMethodicalWork.all
    respond_with(@organizational_and_methodical_works)
  end

  def show
    respond_with(@organizational_and_methodical_work)
  end

  def new
    @organizational_and_methodical_work = OrganizationalAndMethodicalWork.new
    respond_with(@organizational_and_methodical_work)
  end

  def edit
  end

  def create
    @organizational_and_methodical_work = OrganizationalAndMethodicalWork.new(organizational_and_methodical_work_params)
    @organizational_and_methodical_work.save
    respond_with(@organizational_and_methodical_work)
  end

  def update
    @organizational_and_methodical_work.update(organizational_and_methodical_work_params)
    respond_with(@organizational_and_methodical_work)
  end

  def destroy
    @organizational_and_methodical_work.destroy
    respond_with(@organizational_and_methodical_work)
  end

  private
    def set_organizational_and_methodical_work
      @organizational_and_methodical_work = OrganizationalAndMethodicalWork.find(params[:id])
    end

    def organizational_and_methodical_work_params
      # params[:organizational_and_methodical_work]
      params.require(:organizational_and_methodical_work).permit(:work_name, :time_rate, :note)
    end
end
