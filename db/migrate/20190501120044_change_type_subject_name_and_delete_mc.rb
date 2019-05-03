class ChangeTypeSubjectNameAndDeleteMc < ActiveRecord::Migration[5.2]
  def change
    change_column :extramular_subjects, :subject_name, :string
    remove_column :extramular_subjects, :modular_control_b
    remove_column :extramular_subjects, :modular_control_c
  end
end
