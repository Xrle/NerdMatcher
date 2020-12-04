class RedesignDb < ActiveRecord::Migration[5.2]
  def change
    #Remove all tables
    drop_table :likes
    drop_table :dislikes
    drop_table :matches
    drop_table :people
    drop_table :users

    #Remake merging users and people, and modifying join tables
    create_table :users do |t|
      t.string :username, null: false
      #password_digest for use with has_secure_password
      t.string :password_digest, null: false
      t.text :queue

      t.string :name, null: false
      t.date :dob, null: false
      #Use integer so that and enum can be used at the model level
      t.integer :gender, null: false
      t.text :bio

      t.timestamps
    end

    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :liked_id, null: false

      t.timestamps
    end

    create_table :dislikes do |t|
      t.integer :user_id, null: false
      t.integer :disliked_id, null: false

      t.timestamps
    end

    create_table :matches do |t|
      t.integer :user_id, null: false
      t.integer :matched_id, null: false

      t.timestamps
    end

    #Add indexes
    add_index :users, :username, unique: true
    add_index :likes, [:user_id, :liked_id], unique: true
    add_index :dislikes, [:user_id, :disliked_id], unique: true
    add_index :matches, [:user_id, :matched_id], unique: true

  end
end
