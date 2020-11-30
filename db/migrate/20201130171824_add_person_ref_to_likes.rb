class AddPersonRefToLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :person_id
    add_reference :likes, :person, foreign_key: true, null: false
  end
end
