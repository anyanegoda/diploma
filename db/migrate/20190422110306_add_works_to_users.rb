class AddWorksToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :educational_and_methodical_works, :string
    add_column :users, :organizational_and_methodical_works, :string
    add_column :users, :research_works, :string
    add_column :users, :educational_works, :string
  end
end
