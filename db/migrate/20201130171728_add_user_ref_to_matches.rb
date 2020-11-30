class AddUserRefToMatches < ActiveRecord::Migration[5.2]
  def change
    remove_column :matches, :user_id
    add_reference :matches, :user, foreign_key: true, null: false
  end
end
