class RemoveUserRefFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_reference :people, :user, foreign_key: true
  end
end
