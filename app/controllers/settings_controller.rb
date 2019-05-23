class SettingsController < ApplicationController
  require 'roo'
  require "pry"
  require 'rubygems'
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # @settings = Setting.all
    # @title = 'НАСТРОЙКИ'
    # @subtitle = 'Редактирование названий столбцов для считывания с файла Excel'
    # respond_with(@settings)
  end

  def save_input_file
    @temp = FilesExcel.new
    @temp.input_file = params[:input_file]
    @temp.user_id = current_user.id
    @temp.save
  end

  def insert_to_bd

    # @xls = Roo::Spreadsheet.open('./main.xls', {:expand_merged_ranges => true})
    # current_user.files_excels.each do |file|
    #   @xls = Roo::Spreadsheet.open(file.input_file, {:expand_merged_ranges => true})
    # end
    @xls = Roo::Spreadsheet.open(current_user.files_excels.last.input_file, {:expand_merged_ranges => true})
    puts 'Suuuka'
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
      if value[:name] != nil && value[:name] != setting.discipline_full && value[:name] != 'Аспирантура, докторантура' && value[:name] != 'Вступительные' && value[:name] != ' '
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

  def destroy_all_subjects
    Subject.destroy_all
  end

  def insert_to_bd_extramular
    puts 'Suuuka'
    @xls = Roo::Spreadsheet.open(current_user.files_excels.last.input_file, {:expand_merged_ranges => true})

    setting = Setting.last

    last_row = @xls.sheet(setting.department).last_row
    last_column = @xls.sheet(setting.department).last_column
    if !last_row.nil?
      for row in 1..last_row
        col_contingent = @xls.sheet(setting.department).row(row).find_index(setting.contingent_extramural)
        col_plan = @xls.sheet(setting.department).row(row).find_index(setting.work_plan_extramural)
        col_hours_b = @xls.sheet(setting.department).row(row).find_index(setting.budget_hours_extramural)
        col_hours_d = @xls.sheet(setting.department).row(row).find_index(setting.contract_hours_extramural)

        if col_contingent != nil
          contingent_row = row
          contingent_b_col = col_contingent + 1
          contingent_c_col = col_contingent + 2
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

    binding.pry

    for col in plan_col..hours_b_col-1
      row_test = @xls.sheet(setting.department).column(col).find_index(setting.test_plan_extramural)
      row_exam_v = @xls.sheet(setting.department).column(col).find_index(setting.exam_v_extramural)
      row_exam_w = @xls.sheet(setting.department).column(col).find_index(setting.exam_w_extramural)
      if row_test != nil
        test_row = row_test + 2
        test_col = col
      end
      if row_exam_v != nil
        exam_v_row = row_exam_v + 2
        exam_v_col = col
      end
      if row_exam_w != nil
        exam_w_row = row_exam_w + 2
        exam_w_col = col
      end
    end

    for col in hours_b_col..hours_d_col-1
      row_lectures_b = @xls.sheet(setting.department).column(col).find_index(setting.lectures_extramural)
      row_practical_classes_b = @xls.sheet(setting.department).column(col).find_index(setting.practical_classes_extramural)
      row_laboratory_classes_b = @xls.sheet(setting.department).column(col).find_index(setting.laboratory_classes_extramural)
      row_consultation_b = @xls.sheet(setting.department).column(col).find_index(setting.consultation_extramural)
      row_test_b = @xls.sheet(setting.department).column(col).find_index(setting.test_hours_extramural)
      row_exam_b = @xls.sheet(setting.department).column(col).find_index(setting.exam_extramural)
      if row_lectures_b != nil
        lectures_b_row = row_lectures_b + 2
        lectures_b_col = col
      end
      if row_practical_classes_b != nil
        practical_classes_b_row = row_practical_classes_b + 2
        practical_classes_b_col = col
      end
      if row_laboratory_classes_b != nil
        laboratory_classes_b_row = row_laboratory_classes_b + 2
        laboratory_classes_b_col = col
      end
      if row_consultation_b != nil
        consultation_b_row = row_consultation_b + 2
        consultation_semester_b_col = col - 1
        consultation_exam_b_col = col
      end
      if row_test_b != nil
        test_b_row = row_test_b + 2
        test_b_col = col
      end
      if row_exam_b != nil
        exam_b_row = row_exam_b + 2
        exam_b_col = col
      end
    end

    for col in hours_d_col..last_column
      row_lectures_c = @xls.sheet(setting.department).column(col).find_index(setting.lectures_extramural)
      row_practical_classes_c = @xls.sheet(setting.department).column(col).find_index(setting.practical_classes_extramural)
      row_laboratory_classes_c = @xls.sheet(setting.department).column(col).find_index(setting.laboratory_classes_extramural)
      row_consultation_c = @xls.sheet(setting.department).column(col).find_index(setting.consultation_extramural)
      row_test_c = @xls.sheet(setting.department).column(col).find_index(setting.test_hours_extramural)
      row_exam_c = @xls.sheet(setting.department).column(col).find_index(setting.exam_extramural)
      if row_lectures_c != nil
        lectures_c_row = row_lectures_c + 2
        lectures_c_col = col
      end
      if row_practical_classes_c != nil
        practical_classes_c_row = row_practical_classes_c + 2
        practical_classes_c_col = col
      end
      if row_laboratory_classes_c != nil
        laboratory_classes_c_row = row_laboratory_classes_c + 2
        laboratory_classes_c_col = col
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

    @xls.sheet(setting.department).parse(name: setting.discipline_extramural, course: setting.course_extramural, training_direction: setting.training_direction_extramural, group_quantity: setting.subgroups_extramural, clean:true).each do |value|
      contingent_row += 1
      lectures_b_row += 1
      lectures_c_row += 1
      practical_classes_b_row += 1
      practical_classes_c_row += 1
      laboratory_classes_b_row += 1
      laboratory_classes_c_row += 1
      consultation_b_row += 1
      test_b_row += 1
      exam_b_row += 1
      consultation_c_row += 1
      test_c_row += 1
      exam_c_row += 1
      test_row += 1
      exam_v_row += 1
      exam_w_row += 1
      if value[:name] != nil && value[:name] != setting.discipline_extramural

        quantity_test = @xls.sheet(setting.department).cell(test_row, test_col)
        quantity_exam_v = @xls.sheet(setting.department).cell(exam_v_row, exam_v_col)
        quantity_exam_w = @xls.sheet(setting.department).cell(exam_w_row, exam_w_col)
        if quantity_test != nil || quantity_exam_v != nil || quantity_exam_w != nil
          size = quantity_test + quantity_exam_v + quantity_exam_w #quantity semesters
        else
          size = 1
        end

        semesters_course_1 = [1, 2]
        semesters_course_2 = [3, 4]
        semesters_course_3 = [5, 6]
        semesters_course_4 = [7, 8]

        if size >= 2
          quantity_lectures_b = @xls.sheet(setting.department).cell(lectures_b_row, lectures_b_col)
          quantity_lectures_b_sem = Array.new()
          if quantity_lectures_b != nil
            if quantity_lectures_b/quantity_lectures_b.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_lectures_b_sem.push((quantity_lectures_b / size).ceil)
                else
                  quantity_lectures_b_sem.push((quantity_lectures_b / size).floor)
                end
                quantity_lectures_b_sem.push(quantity_lectures_b - (quantity_lectures_b / size).ceil - (quantity_lectures_b / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_lectures_b_sem.push((quantity_lectures_b / size))
                end
                quantity_lectures_b_sem.push(quantity_lectures_b - (quantity_lectures_b / size) - (quantity_lectures_b / size) * (size - 2))
              end
            end
          end

          quantity_lectures_c = @xls.sheet(setting.department).cell(lectures_c_row, lectures_c_col)
          quantity_lectures_c_sem = Array.new()
          if quantity_lectures_c != nil
            if quantity_lectures_c/quantity_lectures_c.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_lectures_c_sem.push((quantity_lectures_c / size).ceil)
                else
                  quantity_lectures_c_sem.push((quantity_lectures_c / size).floor)
                end
                quantity_lectures_c_sem.push(quantity_lectures_c - (quantity_lectures_c / size).ceil - (quantity_lectures_c / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_lectures_c_sem.push((quantity_lectures_c / size))
                end
                quantity_lectures_c_sem.push(quantity_lectures_c - (quantity_lectures_c / size) - (quantity_lectures_c / size) * (size - 2))
              end
            end
          end

          quantity_practical_classes_b = @xls.sheet(setting.department).cell(practical_classes_b_row, practical_classes_b_col)
          quantity_practical_classes_b_sem = Array.new()
          if quantity_practical_classes_b != nil
            if quantity_practical_classes_b/quantity_practical_classes_b.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_practical_classes_b_sem.push((quantity_practical_classes_b / size).ceil)
                else
                  quantity_practical_classes_b_sem.push((quantity_practical_classes_b / size).floor)
                end
                quantity_practical_classes_b_sem.push(quantity_practical_classes_b - (quantity_practical_classes_b / size).ceil - (quantity_practical_classes_b / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_practical_classes_b_sem.push((quantity_practical_classes_b / size))
                end
                quantity_practical_classes_b_sem.push(quantity_practical_classes_b - (quantity_practical_classes_b / size) - (quantity_practical_classes_b / size) * (size - 2))
              end
            end
          end

          quantity_practical_classes_c = @xls.sheet(setting.department).cell(practical_classes_c_row, practical_classes_c_col)
          quantity_practical_classes_c_sem = Array.new()
          if quantity_practical_classes_c != nil
            if quantity_practical_classes_c/quantity_practical_classes_c.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_practical_classes_c_sem.push((quantity_practical_classes_c / size).ceil)
                else
                  quantity_practical_classes_c_sem.push((quantity_practical_classes_c / size).floor)
                end
                quantity_practical_classes_c_sem.push(quantity_practical_classes_c - (quantity_practical_classes_c / size).ceil - (quantity_practical_classes_c / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_practical_classes_c_sem.push((quantity_practical_classes_c / size))
                end
                quantity_practical_classes_c_sem.push(quantity_practical_classes_c - (quantity_practical_classes_c / size) - (quantity_practical_classes_c / size) * (size - 2))
              end
            end
          end

          quantity_laboratory_classes_b = @xls.sheet(setting.department).cell(laboratory_classes_b_row, laboratory_classes_b_col)
          quantity_laboratory_classes_b_sem = Array.new()
          if quantity_laboratory_classes_b != nil
            if quantity_laboratory_classes_b/quantity_laboratory_classes_b.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_laboratory_classes_b_sem.push((quantity_laboratory_classes_b / size).ceil)
                else
                  quantity_laboratory_classes_b_sem.push((quantity_laboratory_classes_b / size).floor)
                end
                quantity_laboratory_classes_b_sem.push(quantity_laboratory_classes_b - (quantity_laboratory_classes_b / size).ceil - (quantity_laboratory_classes_b / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_laboratory_classes_b_sem.push((quantity_laboratory_classes_b / size))
                end
                quantity_laboratory_classes_b_sem.push(quantity_laboratory_classes_b - (quantity_laboratory_classes_b / size) - (quantity_laboratory_classes_b / size) * (size - 2))
              end
            end
          end

          quantity_laboratory_classes_c = @xls.sheet(setting.department).cell(laboratory_classes_c_row, laboratory_classes_c_col)
          quantity_laboratory_classes_c_sem = Array.new()
          if quantity_laboratory_classes_c != nil
            if quantity_laboratory_classes_c/quantity_laboratory_classes_c.floor == 1
              for s in 1..size-1
                if s == 1
                  quantity_laboratory_classes_c_sem.push((quantity_laboratory_classes_c / size).ceil)
                else
                  quantity_laboratory_classes_c_sem.push((quantity_laboratory_classes_c / size).floor)
                end
                quantity_laboratory_classes_c_sem.push(quantity_laboratory_classes_c - (quantity_laboratory_classes_c / size).ceil - (quantity_laboratory_classes_c / size).floor * (size - 2))
              end
            else
              for s in 1..size-1
                if s == 1
                  quantity_laboratory_classes_c_sem.push((quantity_laboratory_classes_c / size))
                end
                quantity_laboratory_classes_c_sem.push(quantity_laboratory_classes_c - (quantity_laboratory_classes_c / size) - (quantity_laboratory_classes_c / size) * (size - 2))
              end
            end
          end

          for i in 0..size-1
            @item = ExtramularSubject.new
            @item.subject_name = value[:name]
            unless value[:course].class == String
              @item.course = value[:course].ceil
            else
              @item.course = value[:course]
            end
            if value[:course] == 1 || value[:course] == "1 М" || value[:course] == "1М" || value[:course] == "1 м" || value[:course] == "1м" || value[:course] == "м1" || value[:course] == "м 1" || value[:course] == "М1" || value[:course] == "М 1"
              @item.semester = semesters_course_1[i]
            elsif value[:course] == 2 || value[:course] == "2 М" || value[:course] == "2М" || value[:course] == "2 м" || value[:course] == "2м" || value[:course] == "м2" || value[:course] == "м 2" || value[:course] == "М2" || value[:course] == "М 2"
              @item.semester = semesters_course_2[i]
            elsif value[:course] == 3
              @item.semester = semesters_course_3[i]
            elsif value[:course] == 4
              @item.semester = semesters_course_4[i]
            end
            @item.training_direction = value[:training_direction]
            @item.student_b_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_b_col)
            @item.student_c_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_c_col)
            @item.lectures_b = quantity_lectures_b_sem[i]
            @item.lectures_c = quantity_lectures_c_sem[i]
            @item.practical_classes_b = quantity_practical_classes_b_sem[i]
            @item.practical_classes_c = quantity_practical_classes_c_sem[i]
            @item.laboratory_classes_b = quantity_laboratory_classes_b_sem[i]
            @item.laboratory_classes_c = quantity_laboratory_classes_c_sem[i]
            @item.consultation_semester_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_semester_b_col)
            @item.consultation_exam_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_exam_b_col)
            @item.test_b = @xls.sheet(setting.department).cell(test_b_row, test_b_col)
            @item.exam_b = @xls.sheet(setting.department).cell(exam_b_row, exam_b_col).round(1)
            @item.consultation_semester_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_semester_c_col)
            @item.consultation_exam_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_exam_c_col)
            @item.test_c = @xls.sheet(setting.department).cell(test_c_row, test_c_col)
            @item.exam_c = @xls.sheet(setting.department).cell(exam_c_row, exam_c_col)
            @item.save
          end
        else
          @item = ExtramularSubject.new
          @item.subject_name = value[:name]
          unless value[:course].class == String
            @item.course = value[:course].ceil
          else
            @item.course = value[:course]
          end
          arr = Subject.find_by(subject_name: value[:name], course: value[:course])
          if arr != nil
            @item.semester = arr.semester
          else
            if value[:course] == 1 || value[:course] == "1 М" || value[:course] == "1М" || value[:course] == "1 м" || value[:course] == "1м" || value[:course] == "м1" || value[:course] == "м 1" || value[:course] == "М1" || value[:course] == "М 1"
              @item.semester = 1
            elsif value[:course] == 2 || value[:course] == "2 М" || value[:course] == "2М" || value[:course] == "2 м" || value[:course] == "2м" || value[:course] == "м2" || value[:course] == "м 2" || value[:course] == "М2" || value[:course] == "М 2"
              @item.semester = 3
            elsif value[:course] == 3
              @item.semester = 5
            elsif value[:course] == 4
              @item.semester = 7
            end
          end
          @item.training_direction = value[:training_direction]
          @item.student_b_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_b_col)
          @item.student_c_quantity = @xls.sheet(setting.department).cell(contingent_row, contingent_c_col)
          @item.lectures_b = @xls.sheet(setting.department).cell(lectures_b_row, lectures_b_col)
          @item.lectures_c = @xls.sheet(setting.department).cell(lectures_c_row, lectures_c_col)
          @item.practical_classes_b = @xls.sheet(setting.department).cell(practical_classes_b_row, practical_classes_b_col)
          @item.practical_classes_c = @xls.sheet(setting.department).cell(practical_classes_c_row, practical_classes_c_col)
          @item.laboratory_classes_b = @xls.sheet(setting.department).cell(laboratory_classes_b_row, laboratory_classes_b_col)
          @item.laboratory_classes_c = @xls.sheet(setting.department).cell(laboratory_classes_c_row, laboratory_classes_c_col)
          @item.consultation_semester_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_semester_b_col)
          @item.consultation_exam_b = @xls.sheet(setting.department).cell(consultation_b_row, consultation_exam_b_col)
          @item.test_b = @xls.sheet(setting.department).cell(test_b_row, test_b_col)
          @item.exam_b = @xls.sheet(setting.department).cell(exam_b_row, exam_b_col).round(1)
          @item.consultation_semester_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_semester_c_col)
          @item.consultation_exam_c = @xls.sheet(setting.department).cell(consultation_c_row, consultation_exam_c_col)
          @item.test_c = @xls.sheet(setting.department).cell(test_c_row, test_c_col)
          @item.exam_c = @xls.sheet(setting.department).cell(exam_c_row, exam_c_col)
          @item.save
        end
      end
    end
  end

  def destroy_all_extramular_subjects
    ExtramularSubject.destroy_all
  end

  def show
    @title = 'НАСТРОЙКИ'
    @subtitle = 'Редактирование названий столбцов для считывания с файла Excel'
    respond_with(@setting)
  end

  def new
    @setting = Setting.new
    respond_with(@setting)
  end

  def edit
    @setting = Setting.first
    @title = 'НАСТРОЙКИ'
    @subtitle = 'Редактирование названий столбцов для считывания с файла Excel'
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
