class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :userid
      t.integer :personid

      t.timestamps
    end
  end
end
