class RenameGringottsUsersToGringottsSettings < ActiveRecord::Migration
  def change
    remove_index :gringotts_users, :user_id
    rename_table :gringotts_users, :gringotts_settings
    add_index    :gringotts_settings, :user_id, :unique => true
  end
end
