class AddNullConstraints < ActiveRecord::Migration[5.2]
  def change
    #People
    change_column_null :people, :user_id, false
    change_column_null :people, :name, false
    change_column_null :people, :dob, false

    #Users
    change_column_null :users, :name, false
    change_column_null :users, :password_digest, false
  end
end
