class AddQueueToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :queue, :text
  end
end
