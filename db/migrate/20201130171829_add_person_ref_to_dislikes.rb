class AddPersonRefToDislikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :dislikes, :person_id
    add_reference :dislikes, :person, foreign_key: true, null: false
  end
end
