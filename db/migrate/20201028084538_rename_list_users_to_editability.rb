class RenameListUsersToEditability < ActiveRecord::Migration[5.2]
  def change
    rename_table :messages, :tasks
  end
end
