class CreateExtramularSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :extramular_subjects do |t|
      t.integer :subject_name
      t.string :course
      t.integer :semester
      t.string :training_direction
      t.string :group_quantity
      t.integer :student_b_quantity
      t.integer :student_c_quantity
      t.float :lectures
      t.float :practical_classes
      t.float :laboratory_classes
      t.float :modular_control_b
      t.float :consultation_semester_b
      t.float :consultation_exam_b
      t.float :test_b
      t.float :exam_b
      t.float :modular_control_c
      t.float :consultation_semester_c
      t.float :consultation_exam_c
      t.float :test_c
      t.float :exam_c
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
