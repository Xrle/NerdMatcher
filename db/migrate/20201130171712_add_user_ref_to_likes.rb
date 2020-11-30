class AddUserRefToLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :user_id
    add_reference :likes, :user, foreign_key: true, null: false
  end
end
