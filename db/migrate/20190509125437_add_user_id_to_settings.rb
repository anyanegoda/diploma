class AddUserIdToSettings < ActiveRecord::Migration[5.2]
  def change
    add_reference :settings, :user, foreign_key: true
  end
end
