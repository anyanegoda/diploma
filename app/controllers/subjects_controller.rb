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
  end

  def remove_subject
    @subject_id = params[:subject_id]
    @temp = Subject.find(@subject_id)
    @temp.user_id = nil
    @temp.save
    # render json: @subject_id
  end

  def save_input_file
    @temp = FilesExcel.new
    @temp.input_file = params[:input_file]
    @temp.user_id = current_user.id
    @temp.save
    # redirect_to root_path
  end

  def insert_user_id
    @subject_id = params[:subject_id]
    @temp = Subject.find(@subject_id)
    @temp.user_id = current_user.id
    @temp.save
    render json: @subject_id
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

  def destroy_all_subjects
    Subject.destroy_all
    redirect_to root_path
  end

  def destroy_all_output_files
    current_user.files_excels.destroy_all
    redirect_to root_path
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
    redirect_to root_path
  end

  def create_excel
    # Create a new Excel Workbook
    file_name = "Plan-#{Time.current.to_s.delete('UTC').parameterize.underscore}_#{current_user.surname}.xlsx"
    # workbook = WriteExcel.new(file_name)
    workbook = WriteXLSX.new(file_name)
    @subjects = Subject.where(user_id: current_user.id)
    @extramular_subjects = ExtramularSubject.where(user_id: current_user.id)
    setting = Setting.last
    # Add worksheet(s)
    worksheet1 = workbook.add_worksheet
    worksheet2 = workbook.add_worksheet
    worksheet3 = workbook.add_worksheet
    worksheet4 = workbook.add_worksheet
    worksheet5 = workbook.add_worksheet
    worksheet6 = workbook.add_worksheet
    worksheet7 = workbook.add_worksheet
    worksheet8 = workbook.add_worksheet
    worksheet9 = workbook.add_worksheet
    worksheet10 = workbook.add_worksheet
    worksheet1.activate

    format_row_8_rotation = workbook.add_format(
                                        :rotation => 90,
                                        :text_wrap => 1,
                                        :align   => 'center',
                                        :size => 8,
                                        :border => 2,
                                        :font => 'Times New Roman',
    )
    format_row_8 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 8,
                                        :text_wrap => 1,
                                        :border => 2,
                                        :font => 'Times New Roman',
    )
    format_8 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 8,
                                        :text_wrap => 1,
                                        :border => 1,
                                        :font => 'Arial'
    )
    format_8_works = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 8,
                                        :font => 'Times New Roman',
    )
    format_8_bold_border = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 8,
                                        :text_wrap => 1,
                                        :border => 1,
                                        :bottom => 2,
                                        :top => 2,
                                        :font => 'Arial'
    )
    format_9_bold_border = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 9,
                                        :border => 2,
                                        :font => 'Times New Roman',
                                        :text_wrap => 1,
    )
    format_10_bold_border = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 10,
                                        :border => 2,
                                        :font => 'Times New Roman',
                                        :text_wrap => 1,
    )
    format_bold_10 = workbook.add_format(
                                        :align => 'left',
                                        :bold => 1,
                                        :size => 10,
                                        :font => 'Times New Roman',
    )
    format_row_11 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'left',
                                        :size => 11,
                                        :border => 2,
                                        :font => 'Times New Roman',
    )
    format_11 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 11,
                                        :border => 1,
                                        :font => 'Times New Roman',
    )
    format_bold_11 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 11,
                                        :font => 'Times New Roman',
                                        :bold => 1,
    )
    format_11_works = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 11,
                                        :font => 'Times New Roman',
    )
    format_11_left = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'left',
                                        :size => 11,
                                        :border => 1,
                                        :font => 'Times New Roman',
    )

    format_title_center = workbook.add_format(
                                        :align => 'center',
                                        :bold => 1,
                                        :size => 11,
                                        :font => 'Times New Roman',
                                        :border => 1,
                                        :bottom => 2,
                                        :top => 2,
    )
    format_title_left = workbook.add_format(
                                        :align => 'left',
                                        :bold => 1,
                                        :size => 11,
                                        :border => 1,
                                        :bottom => 2,
                                        :top => 2,
                                        :font => 'Times New Roman',
    )

    format_title_italic = workbook.add_format(
                                        :align => 'left',
                                        :bold => 1,
                                        :size => 11,
                                        :italic => 1,
                                        :font => 'Times New Roman',
                                        :border => 1,
                                        :bottom => 2,
                                        :top => 2,
    )
    format_bold_14 = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'center',
                                        :size => 14,
                                        :bold => 1,
                                        :font => 'Times New Roman',
                                      )
    format_12_center = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'center',
                                      :size => 12,
                                      :font => 'Times New Roman',
                                    )
    format_bold_12_left = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 12,
                                      :bold => 1,
                                      :font => 'Times New Roman',
                                    )
    format_12_left = workbook.add_format(
                                    :valign  => 'vcenter',
                                    :align   => 'left',
                                    :size => 12,
                                    :font => 'Times New Roman',
                                  )
    format_bold_12_underline = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 12,
                                      :bold => 1,
                                      :font => 'Times New Roman',
                                      :underline => 1,
                                    )
    format_12_underline = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 12,
                                      :font => 'Times New Roman',
                                      :underline => 1,
                                    )
    format_12_center_table = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'center',
                                      :size => 12,
                                      :font => 'Times New Roman',
                                      :bottom => 1,
                                      :top => 1,
                                      :left => 2,
                                      :right => 2,
                                    )
    format_12_left_table = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 12,
                                      :font => 'Times New Roman',
                                      :bottom => 1,
                                      :top => 1,
                                      :left => 2,
                                      :right => 2,
                                      :text_wrap => 1,
                                    )
    format_12_bold_left_table = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 12,
                                      :font => 'Times New Roman',
                                      :bold => 1,
                                      :bottom => 1,
                                      :top => 1,
                                      :left => 2,
                                      :right => 2,
                                      :text_wrap => 1,
                                    )
    format_13 = workbook.add_format(
                                      :valign  => 'vcenter',
                                      :align   => 'left',
                                      :size => 13,
                                      :font => 'Times New Roman',
                                      :text_wrap => 1,
                                    )
    format_bold_14_left = workbook.add_format(
                                        :valign  => 'vcenter',
                                        :align   => 'left',
                                        :size => 14,
                                        :bold => 1,
                                        :font => 'Times New Roman',
                                      )
    format_bold_16 = workbook.add_format(
                                    :valign  => 'vcenter',
                                    :align   => 'center',
                                    :size => 16,
                                    :bold => 1,
                                    :font => 'Times New Roman',
                                  )
    format_bold_22 = workbook.add_format(
                                    :valign  => 'vcenter',
                                    :align   => 'center',
                                    :size => 22,
                                    :bold => 1,
                                    :font => 'Times New Roman',
                                  )

    #Титульный лист
    worksheet1.merge_range('A1:F1', 'Государственное образовательное учреждение', format_bold_16)
    worksheet1.merge_range('A2:F2', 'Высшего профессионального образования', format_bold_16)
    worksheet1.merge_range('A3:F3', '«Донецкий национальный  университет»', format_bold_16)
    worksheet1.set_column('A1:F1', 14)
    worksheet1.merge_range('D5:F5', 'УТВЕРЖДАЮ', format_bold_14_left)
    worksheet1.merge_range('C7:F7', 'Декан (директор) факультета (института)', format_12_center)
    worksheet1.merge_range('D9:F9', '______________________ ', format_12_left)
    worksheet1.merge_range('D10:F10', '"___"  ________________  2018 г.', format_bold_12_left)
    worksheet1.merge_range('A14:B14', 'Факультет/институт', format_12_left)
    worksheet1.merge_range('C14:D14', 'физико-технический', format_bold_12_underline)
    worksheet1.write('A16', 'Кафедра', format_12_left)
    worksheet1.merge_range('B16:C16', 'Компьютерных технологий', format_bold_12_underline)
    worksheet1.merge_range('A21:F21', 'ИНДИВИДУАЛЬНЫЙ ПЛАН', format_bold_22)
    worksheet1.merge_range('A22:F22', "работы преподавателя на #{setting.years} учебный год ", format_bold_16)
    worksheet1.merge_range('A25:B25', 'Фамилия, имя, отчество ', format_bold_12_left)
    worksheet1.merge_range('C25:F25', "#{current_user.surname} #{current_user.name} #{current_user.patronymic}", format_12_underline)
    worksheet1.merge_range('A27:C27', 'Ученое звание и ученая степень', format_bold_12_left)
    worksheet1.merge_range('D27:F27', "#{current_user.academic_degree}", format_12_underline)
    worksheet1.write('A29', 'Должность', format_bold_12_left)
    worksheet1.merge_range('B29:F29', "#{current_user.post}", format_12_underline)
    worksheet1.merge_range('A31:B31', 'Ставка или ее часть', format_bold_12_left)
    worksheet1.merge_range('C31:F31', "#{current_user.rate}", format_12_underline)
    worksheet1.merge_range('A34:F34', 'Утверждён на заседании кафедры "30" августа 2018 г', format_bold_12_left)
    worksheet1.merge_range('A35:F35', 'Протокол № 2', format_bold_12_left)
    worksheet1.merge_range('A36:B36', 'Заведующий кафедрой', format_bold_12_left)
    worksheet1.write('C36', ' ____________________', format_12_left)
    worksheet1.merge_range('D36:F36', 'Ермоленко Т.В.', format_12_underline)

    #ОСЕННИЙ СЕМЕСТР
    worksheet2.set_row(3, 75)
    worksheet2.set_row(2, 20)
    worksheet2.set_column('A3:A4', 51) # For extra visibility.
    worksheet2.set_column('B3:B4', 8)
    worksheet2.set_column('C3:C4', 6)
    worksheet2.set_column('D4:W4', 3)
    worksheet2.set_column('O4:R4', 3.5)
    worksheet2.set_column('X3:X4', 4.5)
    worksheet2.merge_range('A1:X1', "1. Учебная работа на #{setting.years} уч.год", format_bold_14)
    worksheet2.write('A2', 'ОСЕННИЙ СЕМЕСТР', format_bold_10)
    worksheet2.merge_range('A3:A4', 'Название учебных дисциплин и видов учебной работы', format_row_11)
    worksheet2.merge_range('B3:B4', 'Направле ние, специаль ность, факультет', format_row_8)
    worksheet2.merge_range('C3:C4', 'Группа (поток)', format_row_8)
    worksheet2.merge_range('D3:D4', 'курс обучения', format_row_8_rotation)
    worksheet2.merge_range('E3:E4', 'кол-во студентов', format_row_8_rotation)
    worksheet2.merge_range('F3:F4', 'лекции', format_row_8_rotation)
    worksheet2.merge_range('G3:G4', 'практ.(сем.) занятия', format_row_8_rotation)
    worksheet2.merge_range('H3:H4', 'лаб. занятия', format_row_8_rotation)
    worksheet2.merge_range('I3:I4', 'мод.контр.', format_row_8_rotation)
    worksheet2.merge_range('J3:K3', 'консуль тации', format_row_8)
    worksheet2.write('J4', 'в течении семестра', format_row_8_rotation)
    worksheet2.write('K4', ' перед экзаменом', format_row_8_rotation)
    worksheet2.merge_range('L3:L4', 'зачеты', format_row_8_rotation)
    worksheet2.merge_range('M3:M4', 'экзамены', format_row_8_rotation)
    worksheet2.merge_range('N3:N4', 'Курсовые работы', format_row_8_rotation)
    worksheet2.merge_range('O3:O4', 'Дипломная работа бакалавра', format_row_8_rotation)
    worksheet2.merge_range('P3:P4', 'Дипломная работа специалиста', format_row_8_rotation)
    worksheet2.merge_range('Q3:Q4', 'Магистерская диссертация', format_row_8_rotation)
    worksheet2.merge_range('R3:R4', 'рук. практикой', format_row_8_rotation)
    worksheet2.merge_range('S3:S4', 'гос. экзамены', format_row_8_rotation)
    worksheet2.merge_range('T3:T4', 'рецензирование ВКР', format_row_8_rotation)
    worksheet2.merge_range('U3:U4', 'защита ВКР', format_row_8_rotation)
    worksheet2.merge_range('V3:V4', 'рук-во аспирантами', format_row_8_rotation)
    worksheet2.merge_range('W3:W4', 'др.виды уч.нагрузки', format_row_8_rotation)
    worksheet2.merge_range('X3:X4', 'ВСЕГО', format_row_8_rotation)

    #ВЕСЕННИЙ СЕМЕСТР
    worksheet3.set_row(3, 75)
    worksheet3.set_row(2, 20)
    worksheet3.set_column('A3:A4', 51) # For extra visibility.
    worksheet3.set_column('B3:B4', 8)
    worksheet3.set_column('C3:C4', 6)
    worksheet3.set_column('D4:W4', 3)
    worksheet3.set_column('O4:R4', 3.5)
    worksheet3.set_column('X3:X4', 4.5)
    worksheet3.merge_range('A1:X1', "1. Учебная работа на #{setting.years} уч.год", format_bold_14)
    worksheet3.write('A2', 'ВЕСЕННИЙ СЕМЕСТР', format_bold_10)
    worksheet3.merge_range('A3:A4', 'Название учебных дисциплин и видов учебной работы', format_row_11)
    worksheet3.merge_range('B3:B4', 'Направле ние, специаль ность, факультет', format_row_8)
    worksheet3.merge_range('C3:C4', 'Группа (поток)', format_row_8)
    worksheet3.merge_range('D3:D4', 'курс обучения', format_row_8_rotation)
    worksheet3.merge_range('E3:E4', 'кол-во студентов', format_row_8_rotation)
    worksheet3.merge_range('F3:F4', 'лекции', format_row_8_rotation)
    worksheet3.merge_range('G3:G4', 'практ.(сем.) занятия', format_row_8_rotation)
    worksheet3.merge_range('H3:H4', 'лаб. занятия', format_row_8_rotation)
    worksheet3.merge_range('I3:I4', 'мод.контр.', format_row_8_rotation)
    worksheet3.merge_range('J3:K3', 'консуль тации', format_row_8)
    worksheet3.write('J4', 'в течении семестра', format_row_8_rotation)
    worksheet3.write('K4', ' перед экзаменом', format_row_8_rotation)
    worksheet3.merge_range('L3:L4', 'зачеты', format_row_8_rotation)
    worksheet3.merge_range('M3:M4', 'экзамены', format_row_8_rotation)
    worksheet3.merge_range('N3:N4', 'Курсовые работы', format_row_8_rotation)
    worksheet3.merge_range('O3:O4', 'Дипломная работа бакалавра', format_row_8_rotation)
    worksheet3.merge_range('P3:P4', 'Дипломная работа специалиста', format_row_8_rotation)
    worksheet3.merge_range('Q3:Q4', 'Магистерская диссертация', format_row_8_rotation)
    worksheet3.merge_range('R3:R4', 'рук. практикой', format_row_8_rotation)
    worksheet3.merge_range('S3:S4', 'гос. экзамены', format_row_8_rotation)
    worksheet3.merge_range('T3:T4', 'рецензирование ВКР', format_row_8_rotation)
    worksheet3.merge_range('U3:U4', 'защита ВКР', format_row_8_rotation)
    worksheet3.merge_range('V3:V4', 'рук-во аспирантами', format_row_8_rotation)
    worksheet3.merge_range('W3:W4', 'др.виды уч.нагрузки', format_row_8_rotation)
    worksheet3.merge_range('X3:X4', 'ВСЕГО', format_row_8_rotation)

    row = 5
    worksheet2.write('A5', 'Очная форма обучения (бюджет)', format_title_center)
    worksheet3.write('A5', 'Очная форма обучения (бюджет)', format_title_center)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row}", format_8_bold_border)
      worksheet3.write_blank("#{letter}#{row}", format_8_bold_border)
    end

    start_b = row + 1
    row_autumn = row
    row_spring = row
    @subjects.each do |subject|
      if subject.student_b_quantity != 0
        if subject.semester % 2 == 0
          row_autumn += 1
          worksheet2.write("A#{row_autumn}", subject.subject_name, format_11_left)
          worksheet2.write("B#{row_autumn}", subject.training_direction, format_11)
          worksheet2.write("C#{row_autumn}", subject.group_quantity, format_11)
          worksheet2.write("D#{row_autumn}", subject.course, format_11)
          worksheet2.write("E#{row_autumn}", subject.student_b_quantity, format_8)
          worksheet2.write("F#{row_autumn}", subject.lectures, format_8)
          worksheet2.write("G#{row_autumn}", subject.practical_classes, format_8)
          worksheet2.write("H#{row_autumn}", subject.laboratory_classes, format_8)
          worksheet2.write("I#{row_autumn}", subject.modular_control_b, format_8)
          worksheet2.write("J#{row_autumn}", subject.consultation_semester_b, format_8)
          worksheet2.write("K#{row_autumn}", subject.consultation_exam_b, format_8)
          worksheet2.write("L#{row_autumn}", subject.test_b, format_8)
          worksheet2.write("M#{row_autumn}", subject.exam_b, format_8)
          worksheet2.write("X#{row_autumn}", "=SUM(F#{row_autumn}:W#{row_autumn})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
          end
        else
          row_spring += 1
          worksheet3.write("A#{row_spring}", subject.subject_name, format_11_left)
          worksheet3.write("B#{row_spring}", subject.training_direction, format_11)
          worksheet3.write("C#{row_spring}", subject.group_quantity, format_11)
          worksheet3.write("D#{row_spring}", subject.course, format_11)
          worksheet3.write("E#{row_spring}", subject.student_b_quantity, format_8)
          worksheet3.write("F#{row_spring}", subject.lectures, format_8)
          worksheet3.write("G#{row_spring}", subject.practical_classes, format_8)
          worksheet3.write("H#{row_spring}", subject.laboratory_classes, format_8)
          worksheet3.write("I#{row_spring}", subject.modular_control_b, format_8)
          worksheet3.write("J#{row_spring}", subject.consultation_semester_b, format_8)
          worksheet3.write("K#{row_spring}", subject.consultation_exam_b, format_8)
          worksheet3.write("L#{row_spring}", subject.test_b, format_8)
          worksheet3.write("M#{row_spring}", subject.exam_b, format_8)
          worksheet3.write("X#{row_spring}", "=SUM(F#{row_spring}:W#{row_spring})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet3.write_blank("#{letter}#{row_spring}", format_8)
          end
        end
      end
    end

    row_autumn += 1
    row_spring += 1
    end_b_autumn = row_autumn
    end_b_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по очной форме обучения (бюджет)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого по очной форме обучения (бюджет)', format_title_left)
    ("B".."E").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."E").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{start_b}:#{letter}#{row_autumn-1})",format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{start_b}:#{letter}#{row_spring-1})",format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Очная форма обучения (контракт)', format_title_center)
    worksheet3.write("A#{row_spring}", 'Очная форма обучения (контракт)', format_title_center)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    start_c_autumn = row_autumn + 1
    start_c_spring = row_spring + 1
    @subjects.each do |subject|
      if subject.student_c_quantity != 0
        if subject.semester % 2 == 0
          row_autumn += 1
          worksheet2.write("A#{row_autumn}", subject.subject_name, format_11_left)
          worksheet2.write("B#{row_autumn}", subject.training_direction, format_11)
          # worksheet2.write("C#{row_autumn}", subject.group_quantity, format_11)
          worksheet2.write_blank("C#{row_autumn}", format_11)
          worksheet2.write("D#{row_autumn}", subject.course, format_11)
          worksheet2.write("E#{row_autumn}", subject.student_c_quantity, format_8)
          worksheet2.write_blank("F#{row_autumn}", format_11)
          worksheet2.write_blank("G#{row_autumn}", format_11)
          worksheet2.write_blank("H#{row_autumn}", format_11)
          # worksheet2.write("F#{row_autumn}", subject.lectures, format_8)
          # worksheet2.write("G#{row_autumn}", subject.practical_classes, format_8)
          # worksheet2.write("H#{row_autumn}", subject.laboratory_classes, format_8)
          worksheet2.write("I#{row_autumn}", subject.modular_control_c, format_8)
          worksheet2.write("J#{row_autumn}", subject.consultation_semester_c, format_8)
          worksheet2.write("K#{row_autumn}", subject.consultation_exam_c, format_8)
          worksheet2.write("L#{row_autumn}", subject.test_c, format_8)
          worksheet2.write("M#{row_autumn}", subject.exam_c, format_8)
          ("N".."W").to_a.each do |letter|
            worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
          end
          worksheet2.write("X#{row_autumn}", "=SUM(F#{row_autumn}:W#{row_autumn})", format_8)
        else
          row_spring += 1
          worksheet3.write("A#{row_spring}", subject.subject_name, format_11_left)
          worksheet3.write("B#{row_spring}", subject.training_direction, format_11)
          # worksheet3.write("C#{row_spring}", subject.group_quantity, format_11)
          worksheet3.write_blank("C#{row_spring}", format_11)
          worksheet3.write("D#{row_spring}", subject.course, format_11)
          worksheet3.write("E#{row_spring}", subject.student_c_quantity, format_8)
          worksheet3.write_blank("F#{row_spring}", format_11)
          worksheet3.write_blank("G#{row_spring}", format_11)
          worksheet3.write_blank("H#{row_spring}", format_11)
          # worksheet3.write("F#{row_spring}", subject.lectures, format_8)
          # worksheet3.write("G#{row_spring}", subject.practical_classes, format_8)
          # worksheet3.write("H#{row_spring}", subject.laboratory_classes, format_8)
          worksheet3.write("I#{row_spring}", subject.modular_control_c, format_8)
          worksheet3.write("J#{row_spring}", subject.consultation_semester_c, format_8)
          worksheet3.write("K#{row_spring}", subject.consultation_exam_c, format_8)
          worksheet3.write("L#{row_spring}", subject.test_c, format_8)
          worksheet3.write("M#{row_spring}", subject.exam_c, format_8)
          ("N".."W").to_a.each do |letter|
            worksheet3.write_blank("#{letter}#{row_spring}", format_8)
          end
          worksheet3.write("X#{row_spring}", "=SUM(F#{row_spring}:W#{row_spring})", format_8)
        end
      end
    end

    row_autumn += 1
    row_spring += 1
    total_full_contract_autumn = row_autumn
    total_full_contract_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по очной форме обучения (контракт)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого по очной форме обучения (контракт)', format_title_left)
    # worksheet2.write("F#{row}", "=SUM(F#{start_c}:F#{row-1})")
    # worksheet2.write("G#{row}", "=SUM(G#{start_c}:G#{row-1})")
    # worksheet2.write("H#{row}", "=SUM(H#{start_c}:H#{row-1})")
    ("B".."H").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{start_c_autumn}:#{letter}#{row_autumn-1})", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{start_c_spring}:#{letter}#{row_spring-1})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_budget_autumn = row_autumn
    total_budget_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по очной форме обучения', format_title_italic)
    worksheet3.write("A#{row_spring}", 'Итого по очной форме обучения', format_title_italic)
    ("B".."E").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."E").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{end_b_autumn},#{letter}#{row_autumn-1})", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{end_b_spring},#{letter}#{row_spring-1})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Заочная форма обучения (бюджет)', format_title_center)
    worksheet3.write("A#{row_spring}", 'Заочная форма обучения (бюджет)', format_title_center)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end

    start_extr_b_autumn = row_autumn + 1
    start_extr_b_spring = row_spring + 1

    @extramular_subjects.each do |extramular_subject|
      if extramular_subject.student_b_quantity != 0
        if extramular_subject.semester % 2 == 0
          row_autumn += 1
          worksheet2.write("A#{row_autumn}", extramular_subject.subject_name, format_11_left)
          worksheet2.write("B#{row_autumn}", extramular_subject.training_direction, format_11)
          worksheet2.write("C#{row_autumn}", extramular_subject.group_quantity, format_11)
          worksheet2.write("D#{row_autumn}", extramular_subject.course, format_11)
          worksheet2.write("E#{row_autumn}", extramular_subject.student_b_quantity, format_8)
          worksheet2.write("F#{row_autumn}", extramular_subject.lectures_b, format_8)
          worksheet2.write("G#{row_autumn}", extramular_subject.practical_classes_b, format_8)
          worksheet2.write("H#{row_autumn}", extramular_subject.laboratory_classes_b, format_8)
          worksheet2.write_blank("I#{row_autumn}", format_8)
          worksheet2.write("J#{row_autumn}", extramular_subject.consultation_semester_b, format_8)
          worksheet2.write("K#{row_autumn}", extramular_subject.consultation_exam_b, format_8)
          worksheet2.write("L#{row_autumn}", extramular_subject.test_b, format_8)
          worksheet2.write("M#{row_autumn}", extramular_subject.exam_b, format_8)
          worksheet2.write("X#{row_autumn}", "=SUM(F#{row_autumn}:W#{row_autumn})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
          end
        else
          row_spring += 1
          worksheet3.write("A#{row_spring}", extramular_subject.subject_name, format_11_left)
          worksheet3.write("B#{row_spring}", extramular_subject.training_direction, format_11)
          worksheet3.write("C#{row_spring}", extramular_subject.group_quantity, format_11)
          worksheet3.write("D#{row_spring}", extramular_subject.course, format_11)
          worksheet3.write("E#{row_spring}", extramular_subject.student_b_quantity, format_8)
          worksheet3.write("F#{row_spring}", extramular_subject.lectures_b, format_8)
          worksheet3.write("G#{row_spring}", extramular_subject.practical_classes_b, format_8)
          worksheet3.write("H#{row_spring}", extramular_subject.laboratory_classes_b, format_8)
          worksheet3.write_blank("I#{row_spring}", format_8)
          worksheet3.write("J#{row_spring}", extramular_subject.consultation_semester_b, format_8)
          worksheet3.write("K#{row_spring}", extramular_subject.consultation_exam_b, format_8)
          worksheet3.write("L#{row_spring}", extramular_subject.test_b, format_8)
          worksheet3.write("M#{row_spring}", extramular_subject.exam_b, format_8)
          worksheet3.write("X#{row_spring}", "=SUM(F#{row_spring}:W#{row_spring})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet3.write_blank("#{letter}#{row_spring}", format_8)
          end
        end
      end
    end

    row_autumn += 1
    row_spring += 1
    total_extr_budget_autumn = row_autumn
    total_extr_budget_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по заочной форме обучения (бюджет)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого по заочной форме обучения (бюджет)', format_title_left)
    ("B".."E").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."E").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{start_extr_b_autumn}:#{letter}#{row_autumn-1})",format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{start_extr_b_spring}:#{letter}#{row_spring-1})",format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Заочная форма обучения (контракт)', format_title_center)
    worksheet3.write("A#{row_spring}", 'Заочная форма обучения (контракт)', format_title_center)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end

    start_extr_c_autumn = row_autumn + 1
    start_extr_c_spring = row_spring + 1
    @extramular_subjects.each do |extramular_subject|
      if extramular_subject.student_c_quantity != 0
        if extramular_subject.semester % 2 == 0
          row_autumn += 1
          worksheet2.write("A#{row_autumn}", extramular_subject.subject_name, format_11_left)
          worksheet2.write("B#{row_autumn}", extramular_subject.training_direction, format_11)
          worksheet2.write("C#{row_autumn}", extramular_subject.group_quantity, format_11)
          worksheet2.write("D#{row_autumn}", extramular_subject.course, format_11)
          worksheet2.write("E#{row_autumn}", extramular_subject.student_c_quantity, format_8)
          worksheet2.write("F#{row_autumn}", extramular_subject.lectures_c, format_8)
          worksheet2.write("G#{row_autumn}", extramular_subject.practical_classes_c, format_8)
          worksheet2.write("H#{row_autumn}", extramular_subject.laboratory_classes_c, format_8)
          worksheet2.write_blank("I#{row_autumn}", format_8)
          worksheet2.write("J#{row_autumn}", extramular_subject.consultation_semester_c, format_8)
          worksheet2.write("K#{row_autumn}", extramular_subject.consultation_exam_c, format_8)
          worksheet2.write("L#{row_autumn}", extramular_subject.test_c, format_8)
          worksheet2.write("M#{row_autumn}", extramular_subject.exam_c, format_8)
          worksheet2.write("X#{row_autumn}", "=SUM(F#{row_autumn}:W#{row_autumn})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
          end
        else
          row_spring += 1
          worksheet3.write("A#{row_spring}", extramular_subject.subject_name, format_11_left)
          worksheet3.write("B#{row_spring}", extramular_subject.training_direction, format_11)
          worksheet3.write("C#{row_spring}", extramular_subject.group_quantity, format_11)
          worksheet3.write("D#{row_spring}", extramular_subject.course, format_11)
          worksheet3.write("E#{row_spring}", extramular_subject.student_c_quantity, format_8)
          worksheet3.write("F#{row_spring}", extramular_subject.lectures_c, format_8)
          worksheet3.write("G#{row_spring}", extramular_subject.practical_classes_c, format_8)
          worksheet3.write("H#{row_spring}", extramular_subject.laboratory_classes_c, format_8)
          worksheet3.write_blank("I#{row_spring}", format_8)
          worksheet3.write("J#{row_spring}", extramular_subject.consultation_semester_c, format_8)
          worksheet3.write("K#{row_spring}", extramular_subject.consultation_exam_c, format_8)
          worksheet3.write("L#{row_spring}", extramular_subject.test_c, format_8)
          worksheet3.write("M#{row_spring}", extramular_subject.exam_c, format_8)
          worksheet3.write("X#{row_spring}", "=SUM(F#{row_spring}:W#{row_spring})", format_8)
          ("N".."W").to_a.each do |letter|
            worksheet3.write_blank("#{letter}#{row_spring}", format_8)
          end
        end
      end
    end

    row_autumn += 1
    row_spring += 1
    total_extr_contract_autumn = row_autumn
    total_extr_contract_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по заочной форме обучения (контракт)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого по заочной форме обучения (контракт)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{start_extr_c_autumn}:#{letter}#{row_autumn-1})", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{start_extr_c_spring}:#{letter}#{row_spring-1})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_contract_autumn = row_autumn
    total_contract_spring = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого по заочной форме обучения', format_title_italic)
    worksheet3.write("A#{row_spring}", 'Итого по заочной форме обучения', format_title_italic)
    ("B".."E").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."E").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{total_extr_budget_autumn},#{letter}#{row_autumn-1})", format_8_bold_border)
    end
    ("F".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{total_extr_budget_spring},#{letter}#{row_spring-1})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_budget_autumn_semester = row_autumn
    total_budget_spring_semester = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого за I семестр (бюджет)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого за II семестр (бюджет)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{end_b_autumn},#{letter}#{total_extr_budget_autumn})", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{end_b_spring}:#{letter}#{total_extr_budget_spring})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_contract_autumn_semester = row_autumn
    total_contract_spring_semester = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого за I семестр (контракт)', format_title_left)
    worksheet3.write("A#{row_spring}", 'Итого за II семестр (контракт)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{total_full_contract_autumn},#{letter}#{total_extr_contract_autumn})", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{total_full_contract_spring}:#{letter}#{total_extr_contract_spring})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_autumn_semester = row_autumn
    total_spring_semester = row_spring
    worksheet2.write("A#{row_autumn}", 'Итого за I семестр', format_title_italic)
    worksheet3.write("A#{row_spring}", 'Итого за II семестр', format_title_italic)
    ("B".."H").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet2.write("#{letter}#{row_autumn}", "=SUM(#{letter}#{total_full_contract_autumn},#{letter}#{total_contract_autumn})", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{total_full_contract_spring},#{letter}#{total_contract_spring})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_budget = row_spring
    worksheet2.merge_range("A#{row_autumn}:X#{row_autumn}", "                                 Преподаватель ____________________________________   Заведующий кафедрой _________________________  ______________________", format_row_11)
    worksheet3.write("A#{row_spring}", 'Всего часов по плану за год (бюджет)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(Sheet2!#{letter}#{total_budget_autumn_semester},#{letter}#{total_budget_spring_semester})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    total_contract = row_spring
    worksheet2.write("A#{row_autumn}", '    ФАКТИЧЕСКОЕ ВЫПОЛНЕНИЕ ЗА I СЕМЕСТР', format_bold_10)
    worksheet3.write("A#{row_spring}", 'Всего часов по плану за год (контракт)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(Sheet2!#{letter}#{total_contract_autumn_semester},#{letter}#{total_contract_spring_semester})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Сентябрь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
    end
    worksheet3.write("A#{row_spring}", 'Всего часов по плану за год (контракт)', format_title_left)
    ("B".."H").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end
    ("I".."X").to_a.each do |letter|
      worksheet3.write("#{letter}#{row_spring}", "=SUM(#{letter}#{total_budget},#{letter}#{total_contract})", format_8_bold_border)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Октябрь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
    end
    worksheet3.merge_range("A#{row_spring}:X#{row_spring}", "                                 Преподаватель ____________________________________   Заведующий кафедрой _________________________  ______________________", format_row_11)

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Ноябрь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
    end
    worksheet3.write("A#{row_spring}", '    ФАКТИЧЕСКОЕ ВЫПОЛНЕНИЕ ЗА II СЕМЕСТР', format_bold_10)

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Декабрь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
    end
    worksheet3.write("A#{row_spring}", 'Январь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Январь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8)
    end
    worksheet3.write("A#{row_spring}", 'Февраль', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.write("A#{row_autumn}", 'Итого за I семестр', format_title_left)
    ("B".."X").to_a.each do |letter|
      worksheet2.write_blank("#{letter}#{row_autumn}", format_8_bold_border)
    end
    worksheet3.write("A#{row_spring}", 'Март', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_autumn += 1
    row_spring += 1
    worksheet2.merge_range("A#{row_autumn}:X#{row_autumn}", "                                 Преподаватель ____________________________________   Заведующий кафедрой _________________________  ______________________", format_row_11)
    worksheet3.write("A#{row_spring}", 'Апрель', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_spring += 1
    worksheet3.write("A#{row_spring}", 'Май', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_spring += 1
    worksheet3.write("A#{row_spring}", 'Июнь', format_11_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8)
    end

    row_spring += 1
    worksheet3.write("A#{row_spring}", 'Итого за II семестр', format_title_left)
    ("B".."X").to_a.each do |letter|
      worksheet3.write_blank("#{letter}#{row_spring}", format_8_bold_border)
    end

    row_spring += 1
    worksheet3.merge_range("A#{row_spring}:X#{row_spring}", "                                 Преподаватель ____________________________________   Заведующий кафедрой _________________________  ______________________", format_row_11)


    #УЧЕБНО-МЕТОДИЧЕСКАЯ РАБОТА
    worksheet4.set_row(0, 24)
    worksheet4.set_row(1, 52)
    worksheet4.set_row(2, 21)
    worksheet4.set_column('A2:A3', 3.4) # For extra visibility.
    worksheet4.set_column('B2:B3', 50)
    worksheet4.set_column('C2:D2', 8)
    worksheet4.set_column('E2:F2', 10)

    worksheet4.merge_range('A1:F1', "ІІ. УЧЕБНО-МЕТОДИЧЕСКАЯ РАБОТА НА #{setting.years} учебный год", format_bold_11)
    worksheet4.merge_range('A2:A3', '№   п/п', format_9_bold_border)
    worksheet4.merge_range('B2:B3', 'Содержание', format_10_bold_border)
    worksheet4.merge_range('C2:D2', 'Кол-во часов', format_10_bold_border)
    worksheet4.write('C3', 'план', format_10_bold_border)
    worksheet4.write('D3', 'факт', format_10_bold_border)
    worksheet4.merge_range('E2:E3', 'Срок выполнения', format_10_bold_border)
    worksheet4.merge_range('F2:F3', 'Отметка о выполнении подпись', format_10_bold_border)

    (1..20).to_a.each do |number|
      worksheet4.write("A#{number+3}", number, format_12_center_table)
      worksheet4.write_blank("B#{number+3}", format_12_left_table)
      worksheet4.write_blank("C#{number+3}", format_12_center_table)
      worksheet4.write_blank("D#{number+3}", format_12_center_table)
      worksheet4.write_blank("E#{number+3}", format_12_center_table)
      worksheet4.write_blank("F#{number+3}", format_12_center_table)
    end
    row_table = 4
    current_user.educational_and_methodical_works.each_pair do |key, value|
      worksheet4.write("B#{row_table}", key, format_12_left_table)
      worksheet4.write("C#{row_table}", value.to_f, format_12_center_table)
      worksheet4.write_blank("D#{row_table}", format_12_center_table)
      worksheet4.write_blank("E#{row_table}", format_12_center_table)
      worksheet4.write_blank("F#{row_table}", format_12_center_table)
      row_table += 1
    end

    worksheet4.write_blank("A24", format_12_center_table)
    worksheet4.write("B24", 'ВСЕГО', format_12_bold_left_table)
    worksheet4.write("C24", "=SUM(C4:C23)", format_12_center_table)
    worksheet4.write_blank("D24", format_12_center_table)
    worksheet4.write_blank("E24", format_12_center_table)
    worksheet4.write_blank("F24", format_12_center_table)
    worksheet4.merge_range('A26:F26', ' Преподаватель ______________ Заведующий кафедрой ____________       ____________________', format_11_works)
    worksheet4.merge_range('A27:F27', '                                 (подпись)                                                                           (подпись)               (фамилия и инициалы)', format_8_works)

    #НАУЧНО-ИССЛЕДОВАТЕЛЬСКАЯ РАБОТА
    worksheet5.set_row(0, 24)
    worksheet5.set_row(1, 52)
    worksheet5.set_row(2, 21)
    worksheet5.set_column('A2:A3', 3.4) # For extra visibility.
    worksheet5.set_column('B2:B3', 50)
    worksheet5.set_column('C2:D2', 8)
    worksheet5.set_column('E2:F2', 10)

    worksheet5.merge_range('A1:F1', "ІІI. НАУЧНО-ИССЛЕДОВАТЕЛЬСКАЯ РАБОТА НА #{setting.years} учебный год", format_bold_11)
    worksheet5.merge_range('A2:A3', '№   п/п', format_9_bold_border)
    worksheet5.merge_range('B2:B3', 'Содержание', format_10_bold_border)
    worksheet5.merge_range('C2:D2', 'Кол-во часов', format_10_bold_border)
    worksheet5.write('C3', 'план', format_10_bold_border)
    worksheet5.write('D3', 'факт', format_10_bold_border)
    worksheet5.merge_range('E2:E3', 'Срок выполнения', format_10_bold_border)
    worksheet5.merge_range('F2:F3', 'Отметка о выполнении подпись', format_10_bold_border)

    (1..20).to_a.each do |number|
      worksheet5.write("A#{number+3}", number, format_12_center_table)
      worksheet5.write_blank("B#{number+3}", format_12_left_table)
      worksheet5.write_blank("C#{number+3}", format_12_center_table)
      worksheet5.write_blank("D#{number+3}", format_12_center_table)
      worksheet5.write_blank("E#{number+3}", format_12_center_table)
      worksheet5.write_blank("F#{number+3}", format_12_center_table)
    end
    row_table = 4
    current_user.research_works.each_pair do |key, value|
      worksheet5.write("B#{row_table}", key, format_12_left_table)
      worksheet5.write("C#{row_table}", value.to_f, format_12_center_table)
      worksheet5.write_blank("D#{row_table}", format_12_center_table)
      worksheet5.write_blank("E#{row_table}", format_12_center_table)
      worksheet5.write_blank("F#{row_table}", format_12_center_table)
      row_table += 1
    end

    worksheet5.write_blank("A24", format_12_center_table)
    worksheet5.write("B24", 'ВСЕГО', format_12_bold_left_table)
    worksheet5.write("C24", "=SUM(C4:C23)", format_12_center_table)
    worksheet5.write_blank("D24", format_12_center_table)
    worksheet5.write_blank("E24", format_12_center_table)
    worksheet5.write_blank("F24", format_12_center_table)
    worksheet5.merge_range('A26:F26', ' Преподаватель ______________ Заведующий кафедрой ____________       ____________________', format_11_works)
    worksheet5.merge_range('A27:F27', '                                 (подпись)                                                                           (подпись)               (фамилия и инициалы)', format_8_works)

    #ОРГАНИЗАЦИОННО-МЕТОДИЧЕСКАЯ РАБОТА
    worksheet6.set_row(0, 24)
    worksheet6.set_row(1, 52)
    worksheet6.set_row(2, 21)
    worksheet6.set_row(19, 24)
    worksheet6.set_row(20, 52)
    worksheet6.set_row(21, 21)
    worksheet6.set_column('A2:A3', 3.4) # For extra visibility.
    worksheet6.set_column('B2:B3', 50)
    worksheet6.set_column('C2:D2', 8)
    worksheet6.set_column('E2:F2', 10)

    worksheet6.merge_range('A1:F1', "ІV. ОРГАНИЗАЦИОННО-МЕТОДИЧЕСКАЯ РАБОТА НА #{setting.years} учебный год", format_bold_11)
    worksheet6.merge_range('A2:A3', '№   п/п', format_9_bold_border)
    worksheet6.merge_range('B2:B3', 'Содержание', format_10_bold_border)
    worksheet6.merge_range('C2:D2', 'Кол-во часов', format_10_bold_border)
    worksheet6.write('C3', 'план', format_10_bold_border)
    worksheet6.write('D3', 'факт', format_10_bold_border)
    worksheet6.merge_range('E2:E3', 'Срок выполнения', format_10_bold_border)
    worksheet6.merge_range('F2:F3', 'Отметка о выполнении подпись', format_10_bold_border)

    (1..12).to_a.each do |number|
      worksheet6.write("A#{number+3}", number, format_12_center_table)
      worksheet6.write_blank("B#{number+3}", format_12_left_table)
      worksheet6.write_blank("C#{number+3}", format_12_center_table)
      worksheet6.write_blank("D#{number+3}", format_12_center_table)
      worksheet6.write_blank("E#{number+3}", format_12_center_table)
      worksheet6.write_blank("F#{number+3}", format_12_center_table)
    end
    row_table = 4
    current_user.organizational_and_methodical_works.each_pair do |key, value|
      worksheet6.write("B#{row_table}", key, format_12_left_table)
      worksheet6.write("C#{row_table}", value.to_f, format_12_center_table)
      worksheet6.write_blank("D#{row_table}", format_12_center_table)
      worksheet6.write_blank("E#{row_table}", format_12_center_table)
      worksheet6.write_blank("F#{row_table}", format_12_center_table)
      row_table += 1
    end

    worksheet6.write_blank("A16", format_12_center_table)
    worksheet6.write("B16", 'ВСЕГО', format_12_bold_left_table)
    worksheet6.write("C16", "=SUM(C4:C15)", format_12_center_table)
    worksheet6.write_blank("D16", format_12_center_table)
    worksheet6.write_blank("E16", format_12_center_table)
    worksheet6.write_blank("F16", format_12_center_table)
    worksheet6.merge_range('A18:F18', ' Преподаватель ______________ Заведующий кафедрой ____________       ____________________', format_11_works)
    worksheet6.merge_range('A19:F19', '                                 (подпись)                                                                           (подпись)               (фамилия и инициалы)', format_8_works)

    #ВОСПИТАТЕЛЬНАЯ РАБОТА
    worksheet6.merge_range('A20:F20', "V. ВОСПИТАТЕЛЬНАЯ РАБОТА НА #{setting.years} учебный год", format_bold_11)
    worksheet6.merge_range('A21:A22', '№   п/п', format_9_bold_border)
    worksheet6.merge_range('B21:B22', 'Содержание', format_10_bold_border)
    worksheet6.merge_range('C21:D21', 'Кол-во часов', format_10_bold_border)
    worksheet6.write('C22', 'план', format_10_bold_border)
    worksheet6.write('D22', 'факт', format_10_bold_border)
    worksheet6.merge_range('E21:E22', 'Срок выполнения', format_10_bold_border)
    worksheet6.merge_range('F21:F22', 'Отметка о выполнении подпись', format_10_bold_border)
    number = 1
    (23..30).to_a.each do |cell|
      worksheet6.write("A#{cell}", number, format_12_center_table)
      worksheet6.write_blank("B#{cell}", format_12_left_table)
      worksheet6.write_blank("C#{cell}", format_12_center_table)
      worksheet6.write_blank("D#{cell}", format_12_center_table)
      worksheet6.write_blank("E#{cell}", format_12_center_table)
      worksheet6.write_blank("F#{cell}", format_12_center_table)
      number += 1
    end
    row_table = 23
    current_user.educational_works.each_pair do |key, value|
      worksheet6.write("B#{row_table}", key, format_12_left_table)
      worksheet6.write("C#{row_table}", value.to_f, format_12_center_table)
      worksheet6.write_blank("D#{row_table}", format_12_center_table)
      worksheet6.write_blank("E#{row_table}", format_12_center_table)
      worksheet6.write_blank("F#{row_table}", format_12_center_table)
      row_table += 1
    end

    worksheet6.write_blank("A31", format_12_center_table)
    worksheet6.write("B31", 'ВСЕГО', format_12_bold_left_table)
    worksheet6.write("C31", "=SUM(C23:C30)", format_12_center_table)
    worksheet6.write_blank("D31", format_12_center_table)
    worksheet6.write_blank("E31", format_12_center_table)
    worksheet6.write_blank("F31", format_12_center_table)
    worksheet6.merge_range('A33:F33', ' Преподаватель ______________ Заведующий кафедрой ____________       ____________________', format_11_works)
    worksheet6.merge_range('A34:F34', '                                 (подпись)                                                                           (подпись)               (фамилия и инициалы)', format_8_works)

    #ПЕРЕЧЕНЬ ИЗМЕНЕНИЙ В ПЛАНЕ РАБОТЫ ПРЕПОДАВАТЕЛЯ
    worksheet7.set_row(0, 24)
    worksheet7.set_row(1, 39)
    worksheet7.set_column('A2:A2', 17.5) # For extra visibility.
    worksheet7.set_column('B2:B2', 54)
    worksheet7.set_column('C2:C2', 16)

    worksheet7.merge_range('A1:C1', 'VI. ПЕРЕЧЕНЬ ИЗМЕНЕНИЙ В ПЛАНЕ РАБОТЫ ПРЕПОДАВАТЕЛЯ', format_bold_11)
    worksheet7.write('A2', 'Дата, вид работ  ', format_9_bold_border)
    worksheet7.write('B2', 'Содержание внесенных изменений и их обоснование', format_10_bold_border)
    worksheet7.write('C2', 'Подпись заведующего кафедрой', format_10_bold_border)

    (1..40).to_a.each do |number|
      worksheet7.write_blank("A#{number+2}", format_12_center_table)
      worksheet7.write_blank("B#{number+2}", format_12_left_table)
      worksheet7.write_blank("C#{number+2}", format_12_center_table)
    end

    #ЗАКЛЮЧЕНИЕ О ВЫПОЛНЕНИИ ПЛАНА
    worksheet8.set_row(0, 24)
    worksheet8.set_row(1, 39)
    worksheet8.set_column('A2:A2', 8.4)
    worksheet8.set_column('B2:B2', 67)
    worksheet8.set_column('C2:C2', 15)

    worksheet8.merge_range('A1:C1', 'VII. ЗАКЛЮЧЕНИЕ О ВЫПОЛНЕНИИ ПЛАНА', format_bold_11)
    worksheet8.write('A2', 'Семестр ', format_9_bold_border)
    worksheet8.write('B2', 'Содержание', format_10_bold_border)
    worksheet8.write('C2', 'Подпись заведующего кафедрой', format_10_bold_border)

    (1..40).to_a.each do |number|
      worksheet8.write_blank("A#{number+2}", format_12_center_table)
      worksheet8.write_blank("B#{number+2}", format_12_left_table)
      worksheet8.write_blank("C#{number+2}", format_12_center_table)
    end

    #ЗАМЕЧАНИЯ ЛИЦ, ПРОВЕРЯЮЩИХ РАБОТУ КАФЕДРЫ
    worksheet9.set_row(0, 24)
    worksheet9.set_row(1, 39)
    worksheet9.set_column('A2:A2', 7)
    worksheet9.set_column('B2:B2', 70)
    worksheet9.set_column('C2:C2', 13)

    worksheet9.merge_range('A1:C1', 'VIII. ЗАМЕЧАНИЯ ЛИЦ, ПРОВЕРЯЮЩИХ РАБОТУ КАФЕДРЫ', format_bold_11)
    worksheet9.write('A2', 'Дата ', format_9_bold_border)
    worksheet9.write('B2', 'Замечания', format_10_bold_border)
    worksheet9.write('C2', 'Подпись проверяющего', format_10_bold_border)

    (1..40).to_a.each do |number|
      worksheet9.write_blank("A#{number+2}", format_12_center_table)
      worksheet9.write_blank("B#{number+2}", format_12_left_table)
      worksheet9.write_blank("C#{number+2}", format_12_center_table)
    end

    #ПОЯСНЕНИЕ к составлению индивидуального плана
    worksheet10.set_row(0, 18.7)
    worksheet10.set_row(1, 18.7)
    worksheet10.set_column('A1:A1', 90)

    worksheet10.write('A1', "ПОЯСНЕНИЕ", format_bold_14)
    worksheet10.write('A2', "к составлению индивидуального плана ", format_bold_14)
    worksheet10.write('A4', "1. Индивидуальный план является основным документом, определяющим объем и содержание работы профессорско-преподавательского состава.", format_13)
    worksheet10.write('A5', "Индивидуальные планы рассматриваются и утверждаются на заседании кафедры:", format_13)
    worksheet10.write('A6', "       - деканов факультетов, их заместителей - проректором (контроль осуществляет  ректор), заведующих кафедрами - деканом (контроль осуществляет проректор);", format_13)
    worksheet10.write('A7', "        - профессорско-преподавательского состава - заведующим кафедрой (контроль осуществляет декан факультета).", format_13)
    worksheet10.write('A8', "2. В разделах индивидуального плана записываются виды работ, связанные с учебной, учебно-методической, научно-исследовательской, организационно-методической и воспитательной работой преподавателя.", format_13)
    worksheet10.write('A9', "2.1. Раздел I - все виды запланированной учебной работы в соответствии с приложением 1 приказа МОН ДНР № 325 от 13.04.2018 «Об утверждении норм времени для планирования объема учебной и внеучебной работы научно-педагогических работников в организациях, осуществляющих образовательную деятельность по реализации образовательных программ высшего профессионального образования».", format_13)
    worksheet10.write('A10', "2.2. Раздел II - основные виды учебно-методической работы, указанные в приложении 2 приказа МОН ДНР № 325 от 13.04.2018 «Об утверждении норм времени для планирования объема учебной и внеучебной работы научно-педагогических работников в организациях, осуществляющих образовательную деятельность по реализации образовательных программ высшего профессионального образования».", format_13)
    worksheet10.write('A11', "2.3. Раздел III - основные виды научно-исследовательской работы, указанные в приложении 2 приказа МОН ДНР № 325 от 13.04.2018 «Об утверждении норм времени для планирования объема учебной и внеучебной работы научно-педагогических работников в организациях, осуществляющих образовательную деятельность по реализации образовательных программ высшего профессионального образования».", format_13)
    worksheet10.write('A12', "2.4. Раздел IV - основные виды организационно-методической работы, указанные в приложении 2 приказа МОН ДНР № 325 от 13.04.2018 «Об утверждении норм времени для планирования объема учебной и внеучебной работы научно-педагогических работников в организациях, осуществляющих образовательную деятельность по реализации образовательных программ высшего профессионального образования».", format_13)
    worksheet10.write('A13', "2.5. Раздел V - основные виды воспитательной работы, указанные в приложении 2 приказа МОН ДНР № 325 от 13.04.2018 «Об утверждении норм времени для планирования объема учебной и внеучебной работы научно-педагогических работников в организациях, осуществляющих образовательную деятельность по реализации образовательных программ высшего профессионального образования».", format_13)
    worksheet10.write('A14', "3. Обобщенный учет выполнения плана ведется в том же бланке. Фактическое выполнение плана визируется заведующим кафедрой. После завершения семестра, учебного года или срока действия трудового договора (контракта), заведующий кафедрой дает заключение о выполнении работ в соответствии с планом и о работе преподавателя в целом.", format_13)

    # write to file
    @output_file = workbook.close
    @temp = FilesExcel.new
    @temp.output_file = File.open(File.join(Rails.root, file_name))
    @temp.user_id = current_user.id
    @temp.save
    #
    # file = open(@output_file)
    # send_data file

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
