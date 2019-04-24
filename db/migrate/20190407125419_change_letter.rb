class ChangeLetter < ActiveRecord::Migration[5.2]
  def change
    rename_column :subjects, :student_с_quantity, :student_c_quantity
  end
end
