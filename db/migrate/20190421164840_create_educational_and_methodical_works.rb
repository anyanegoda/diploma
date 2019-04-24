class CreateEducationalAndMethodicalWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :educational_and_methodical_works do |t|
      t.string :work_name
      t.float :time_rate
      t.string :note
      t.timestamps
    end
  end
end
