class SettingsController < ApplicationController
  require 'roo'
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def save_input_file
    @temp = FilesExcel.new
    @temp.input_file = params[:input_file]
    @temp.user_id = current_user.id
    @temp.save
  end

  def destroy_all_subjects
    Subject.destroy_all
  end

  def insert_to_bd
    # @xls = Roo::Spreadsheet.open('./main.xls', {:expand_merged_ranges => true})
    # current_user.files_excels.each do |file|
    #   @xls = Roo::Spreadsheet.open(file.input_file, {:expand_merged_ranges => true})
    # end
    @xls = Roo::Spreadsheet.open(current_user.files_excels.last.input_file, {:expand_merged_ranges => true})

    setting = Setting.last

    last_row = @xls.sheet(setting.department).last_row
    last_column = @xls.sheet(setting.department).last_column
    if !last_row.nil?
      for row in 1..last_row
        col_contingent = @xls.sheet(setting.department).row(row).find_index(setting.contingent_full)
        col_plan = @xls.sheet(setting.department).row(row).find_index(setting.work_plan_full)
        col_hours_b = @xls.sheet(setting.department).row(row).find_index(setting.budget_hours_full)
        col_hours_d = @xls.sheet(setting.department).row(row).find_index(setting.contract_hours_full)

        if col_contingent != nil
          contingent_row = row
          contingent_b_col = col_contingent + 1
          contingent_d_col = col_contingent + 2
        end
        if col_plan != nil
          plan_row = row
          plan_col = col_plan + 1
        end
        if col_hours_b != nil
          hours_b_col = col_hours_b + 1
          hours_b_row = row
        end
        if col_hours_d != nil
          hours_d_col = col_hours_d + 1
          hours_d_row = row
        end
      end
    else
      puts 'Seems no data in sheet '
    end
    for col in plan_col..hours_b_col-1
      row_lectures = @xls.sheet(setting.department).column(col).find_index(setting.lectures_full)
      row_practical_classes = @xls.sheet(setting.department).column(col).find_index(setting.practical_classes_full)
      row_laboratory_classes = @xls.sheet(setting.department).column(col).find_index(setting.laboratory_classes_full)
      if row_lectures != nil
        lectures_row = row_lectures + 1
        lectures_col = col
      end
      if row_practical_classes != nil
        practical_classes_row = row_practical_classes + 1
        practical_classes_col = col
      end
      if row_laboratory_classes != nil
        laboratory_classes_row = row_laboratory_classes + 1
        laboratory_classes_col = col
      end
    end

    for col in hours_b_col..hours_d_col-1
      row_modular_control_b = @xls.sheet(setting.department).column(col).find_index(setting.modular_control_full)
      row_consultation_b = @xls.sheet(setting.department).column(col).find_index(setting.consultation_full)
      row_test_b = @xls.sheet(setting.department).column(col).find_index(setting.test_hours_full)
      row_exam_b = @xls.sheet(setting.department).column(col).find_index(setting.exam_full)
      if row_modular_control_b != nil
        modular_control_b_row = row_modular_control_b + 1
        modular_control_b_col = col
      end
      if row_consultation_b != nil
        consultation_b_row = row_consultation_b + 1
        consultation_semester_b_col = col - 1
        consultation_exam_b_col = col
      end
      if row_test_b != nil
        test_b_row = row_test_b + 1
        test_b_col = col
      end
      if row_exam_b != nil
        exam_b_row = row_exam_b + 1
        exam_b_col = col
      end
    end

    for col in hours_d_col..last_column
      row_modular_control_c = @xls.sheet(setting.department).column(col).find_index(setting.modular_control_full)
      row_consultation_c = @xls.sheet(setting.department).column(col).find_index(setting.consultation_full)
      row_test_c = @xls.sheet(setting.department).column(col).find_index(setting.test_hours_full)
      row_exam_c = @xls.sheet(setting.department).column(col).find_index(setting.exam_full)
      if row_modular_control_c != nil
        modular_control_c_row = row_modular_control_c + 2
        modular_control_c_col = col
      end
      if row_consultation_c != nil
        consultation_c_row = row_consultation_c + 2
        consultation_semester_c_col = col - 1
        consultation_exam_c_col = col
      end
      if row_test_c != nil
        test_c_row = row_test_c + 2
        test_c_col = col
      end
      if row_exam_c != nil
        exam_c_row = row_exam_c + 2
        exam_c_col = col
      end
    end

    @xls.sheet(setting.department).parse(name: setting.discipline_full, course: setting.course_full, semester: setting.semester_full, training_direction: setting.training_direction_full, group_quantity: setting.subgroups_full, clean:true).each do |value|
      contingent_row += 1
      lectures_row += 1
      practical_classes_row += 1
      laboratory_classes_row += 1
      modular_control_b_row += 1
      consultation_b_row += 1
      test_b_row += 1
      exam_b_row += 1
      modular_control_c_row += 1
      consultation_c_row += 1
      test_c_row += 1
      exam_c_row += 1
      if value[:name] != nil && value[:name] != setting.discipline_full
        @item = Subject.new
        @item.subject_name = value[:name]
        unless value[:course].class == String
          @item.course = value[:course].ceil
        else
          @item.course = value[:course]
        end
        @item.semester = value[:semester]
        @item.training_direction = value[:training_direction]
        @item.group_quantity = value[:group_quantity].ceil
        @item.student_b_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_b_col)
        @item.student_c_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_d_col)
        @item.lectures = @xls.sheet(setting.department).cell(lectures_row, lectures_col)
        @item.practical_classes = @xls.sheet(setting.department).cell(practical_classes_row, practical_classes_col)
        @item.laboratory_classes = @xls.sheet(setting.department).cell(laboratory_classes_row, laboratory_classes_col)
        @item.modular_control_b = @xls.sheet(setting.department).cell(modular_control_b_row, modular_control_b_col)
        @item.consultation_semester_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_semester_b_col)
        @item.consultation_exam_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_exam_b_col)
        @item.test_b = @xls.sheet(setting.department).cell(test_b_row, test_b_col)
        if @xls.sheet(setting.department).cell(exam_b_row, exam_b_col) != nil
          @item.exam_b = @xls.sheet(setting.department).cell(exam_b_row, exam_b_col).round(1)
        end
        if @xls.sheet(setting.department).cell(modular_control_c_row, modular_control_c_col) != nil
          @item.modular_control_c = @xls.sheet(setting.department).cell(modular_control_c_row, modular_control_c_col).round(1)
        end
        @item.consultation_semester_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_semester_c_col)
        @item.consultation_exam_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_exam_c_col)
        @item.test_c = @xls.sheet(setting.department).cell(test_c_row, test_c_col)
        @item.exam_c = @xls.sheet(setting.department).cell(exam_c_row, exam_c_col)
        @item.save
     end
    end
  end

  def index
    @settings = Setting.all
    @title = 'НАСТРОЙКИ'
    @subtitle = 'Редактирование названий столбцов для считывания с файла Excel'
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
      params.require(:setting).permit(:discipline_full, :discipline_extramural, :training_direction_full, :training_direction_extramural, :course_full, :course_extramural, :contingent_full, :contingent_extramural, :subgroups_full, :subgroups_extramural, :semester_full, :lectures_full, :lectures_extramural, :practical_classes_full, :practical_classes_extramural, :laboratory_classes_full, :laboratory_classes_extramural, :consultation_full, :consultation_extramural, :exam_extramural, :test_plan_full, :test_plan_extramural, :test_hours_full, :test_hours_extramural,  :exam_full, :exam_v_extramural, :exam_w_extramural, :work_plan_full, :work_plan_extramural, :budget_hours_full, :budget_hours_extramural, :contract_hours_full, :contract_hours_extramural, :department, :modular_control_full, :years)
    end
end
