class AddYearsToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :years, :string
  end
end
