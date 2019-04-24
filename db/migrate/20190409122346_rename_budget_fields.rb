class RenameBudgetFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :subjects, :modular_control, :modular_control_b
    rename_column :subjects, :consultation_semester, :consultation_semester_b
    rename_column :subjects, :consultation_exam, :consultation_exam_b
    rename_column :subjects, :tests, :test_b
    rename_column :subjects, :exams, :exam_b
  end
end
