class AddPostToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :post, :string
    add_column :users, :academic_degree, :string
    add_column :users, :rate, :float
  end
end
