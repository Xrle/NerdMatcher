class MakePersonRefNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :person_id, false
  end
end
