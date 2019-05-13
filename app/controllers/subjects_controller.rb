class SubjectsController < ApplicationController
  require 'roo'
  require "pry"
  require 'writeexcel'
  require 'rubygems'
  require 'write_xlsx'
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    @title = 'ДИСЦИПЛИНЫ'
    @subtitle = 'Учебная нагрузка очной формы обучения'
  end

  def remove_subject
    @subject_id = params[:subject_id]
    @temp = Subject.find(@subject_id)
    @temp.user_id = nil
    @temp.save
    # render json: @subject_id
  end

  def insert_user_id
    @subject_id = params[:subject_id]
    @temp = Subject.find(@subject_id)
    @temp.user_id = current_user.id
    @user_id = @temp.user_id
    @temp.save
    @surname = "#{User.find(@user_id).surname} #{User.find(@user_id).name.first}. #{User.find(@user_id).patronymic.first}."
    render html: @surname
  end

  def change_user_id
    @subject_id = params[:change_user][:subject_id]
    @user_id = params[:change_user][:user_id]
    @temp = Subject.find(@subject_id)
    @temp.user_id = @user_id
    @temp.save
    @surname = "#{User.find(@user_id).surname} #{User.find(@user_id).name.first}. #{User.find(@user_id).patronymic.first}."
    render html: @surname
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def authorize_subject
      authorize @subject
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:subject_name, :course, :semester, :training_direction, :group_quantity,  :student_b_quantity, :student_c_quantity, :lectures, :practical_classes, :laboratory_classes, :modular_control_b, :consultation_semester_b, :consultation_exam_b, :test_b, :exam_b)
    end
end
