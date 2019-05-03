class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @settings = Setting.all
    respond_with(@settings)
  end

  def show
    respond_with(@setting)
  end

  def new
    @setting = Setting.new
    respond_with(@setting)
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)
    @setting.save
    respond_with(@setting)
  end

  def update
    @setting.update(setting_params)
    respond_with(@setting)
  end

  def destroy
    @setting.destroy
    respond_with(@setting)
  end

  private
    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:discipline_full, :discipline_extramural, :training_direction_full, :training_direction_extramural, :course_full, :course_extramural, :contingent_full, :contingent_extramural, :subgroups_full, :subgroups_extramural, :semester_full, :lectures_full, :lectures_extramural, :practical_classes_full, :practical_classes_extramural, :laboratory_classes_full, :laboratory_classes_extramural, :consultation_full, :consultation_extramural, :exam_extramural, :test_plan_full, :test_plan_extramural, :test_hours_full, :test_hours_extramural,  :exam_full, :exam_v_extramural, :exam_w_extramural, :work_plan_full, :work_plan_extramural, :budget_hours_full, :budget_hours_extramural, :contract_hours_full, :contract_hours_extramural, :department, :modular_control_full)
    end
end
