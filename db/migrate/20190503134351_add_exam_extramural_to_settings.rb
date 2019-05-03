class AddExamExtramuralToSettings < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :consultation_semester_full, :consultation_full
    rename_column :settings, :consultation_semester_extramural, :consultation_extramural
    rename_column :settings, :consultation_exam_extramural, :exam_extramural
    remove_column :settings, :consultation_exam_full
  end
end
