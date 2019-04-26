class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :work_title
      t.float :time_rate
      t.string :note
      t.references :name_work, foreign_key: true

      t.timestamps
    end
  end
end
