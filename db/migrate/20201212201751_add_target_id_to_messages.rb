class AddTargetIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :target_id, :integer, null: false
  end
end
