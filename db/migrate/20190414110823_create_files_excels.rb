class CreateFilesExcels < ActiveRecord::Migration[5.2]
  def change
    create_table :files_excels do |t|
      t.string :input_file
      t.string :output_file
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
