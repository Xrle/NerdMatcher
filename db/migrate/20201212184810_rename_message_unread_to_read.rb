class RenameMessageUnreadToRead < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :unread, :read
  end
end
