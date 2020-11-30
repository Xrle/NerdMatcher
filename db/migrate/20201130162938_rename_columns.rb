class RenameColumns < ActiveRecord::Migration[5.2]
  #Rename columns to follow snake case convention
  def change
    #Dislikes
    rename_column :dislikes, :userid, :user_id
    rename_column :dislikes, :personid, :person_id

    #Likes
    rename_column :likes, :userid, :user_id
    rename_column :likes, :personid, :person_id

    #Matches
    rename_column :matches, :userid, :user_id
    rename_column :matches, :personid, :person_id
  end
end
