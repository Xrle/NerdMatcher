class AddUserRefToDislikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :dislikes, :user_id
    add_reference :dislikes, :user, foreign_key: true, null: false
  end
end
