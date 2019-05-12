class ExtramularSubjectsController < ApplicationController
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

  def insert_to_bd_extramular
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
    redirect_to extramular_subjects_path
  end

  def destroy_all_extramular_subjects
    ExtramularSubject.destroy_all
    redirect_to extramular_subjects_path
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
