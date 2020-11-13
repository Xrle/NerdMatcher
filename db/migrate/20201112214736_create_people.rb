class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.date :dob
      t.text :bio

      t.timestamps
    end
  end
end
