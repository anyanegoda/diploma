class AddDepartmentToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :department, :string
    add_column :settings, :modular_control_full, :string
    add_column :settings, :test_hours_full, :string
    add_column :settings, :test_hours_extramural, :string
    rename_column :settings, :test_full, :test_plan_full
    rename_column :settings, :test_extramural, :test_plan_extramural
  end
end
