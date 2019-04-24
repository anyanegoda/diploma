class CreateResearchWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :research_works do |t|
      t.string :work_name
      t.float :time_rate
      t.string :note
      t.timestamps
    end
  end
end
