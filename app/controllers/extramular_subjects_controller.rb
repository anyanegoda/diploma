class ExtramularSubjectsController < ApplicationController
  require "pry"
  require 'rubygems'
  before_action :set_extramular_subject, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def insert_extramural_user_id
    @subject_id = params[:subject_id]
    @temp = ExtramularSubject.find(@subject_id)
    @temp.user_id = current_user.id
    @user_id = @temp.user_id
    @temp.save
    @surname = "#{User.find(@user_id).surname} #{User.find(@user_id).name.first}. #{User.find(@user_id).patronymic.first}."
    render html: @surname
  end

  def change_ext_user_id
    @subject_id = params[:change_user][:subject_id]
    @user_id = params[:change_user][:user_id]
    @temp = ExtramularSubject.find(@subject_id)
    @temp.user_id = @user_id
    @temp.save
    @surname = "#{User.find(@user_id).surname} #{User.find(@user_id).name.first}. #{User.find(@user_id).patronymic.first}."
    render html: @surname
  end

  def remove_extramular_subject
    @extramular_subject_id = params[:extramular_subject_id]
    @temp = ExtramularSubject.find(@extramular_subject_id)
    @temp.user_id = nil
    @temp.save
  end



  def index
    @extramular_subjects = ExtramularSubject.all
    @title = 'ДИСЦИПЛИНЫ'
    @subtitle = 'Учебная нагрузка заочной формы обучения'
    respond_with(@extramular_subjects)
  end

  def show
    respond_with(@extramular_subject)
  end

  def new
    @extramular_subject = ExtramularSubject.new
    respond_with(@extramular_subject)
  end

  def edit
  end

  def create
    @extramular_subject = ExtramularSubject.new(extramular_subject_params)
    @extramular_subject.save
    respond_with(@extramular_subject)
  end

  def update
    @extramular_subject.update(extramular_subject_params)
    respond_with(@extramular_subject)
  end

  def destroy
    @extramular_subject.destroy
    respond_with(@extramular_subject)
  end

  private
    def authorize_extramular_subject
      authorize @extramular_subject
    end

    def set_extramular_subject
      @extramular_subject = ExtramularSubject.find(params[:id])
    end

    def extramular_subject_params
      params.require(:extramular_subject).permit(:subject_name, :course, :semester, :training_direction, :group_quantity, :student_b_quantity, :student_c_quantity, :lectures, :practical_classes, :laboratory_classes, :modular_control_b, :consultation_semester_b, :consultation_exam_b, :test_b, :exam_b, :modular_control_c, :consultation_semester_c, :consultation_exam_c, :test_c, :exam_c)
    end
end
