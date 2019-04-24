class AddContractFields < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :modular_control_c, :float
    add_column :subjects, :consultation_semester_c, :float
    add_column :subjects, :consultation_exam_c, :float
    add_column :subjects, :test_c, :float
    add_column :subjects, :exam_c, :float
  end
end
