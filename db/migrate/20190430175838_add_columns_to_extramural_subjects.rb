class AddColumnsToExtramuralSubjects < ActiveRecord::Migration[5.2]
  def change
    rename_column :extramular_subjects, :lectures, :lectures_b
    rename_column :extramular_subjects, :practical_classes, :practical_classes_b
    rename_column :extramular_subjects, :laboratory_classes, :laboratory_classes_b
    add_column :extramular_subjects, :lectures_c, :float
    add_column :extramular_subjects, :practical_classes_c, :float
    add_column :extramular_subjects, :laboratory_classes_c, :float
  end
end
