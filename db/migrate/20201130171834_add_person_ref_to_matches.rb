class AddPersonRefToMatches < ActiveRecord::Migration[5.2]
  def change
    remove_column :matches, :person_id
    add_reference :matches, :person, foreign_key: true, null: false
  end
end
