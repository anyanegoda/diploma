class CreateNameWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :name_works do |t|
      t.string :name

      t.timestamps
    end
  end
end
