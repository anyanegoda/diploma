class AddColumnsToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :training_direction, :string
    add_column :subjects, :group_quantity, :string
    add_column :subjects, :student_b_quantity, :integer
    add_column :subjects, :student_с_quantity, :integer
    add_column :subjects, :lectures, :float
    add_column :subjects, :practical_classes, :float
    add_column :subjects, :laboratory_classes, :float
    add_column :subjects, :modular_control, :float
    add_column :subjects, :consultation_semester, :float
    add_column :subjects, :consultation_exam, :float
    add_column :subjects, :tests, :float
    add_column :subjects, :exams, :float

  end
end
