class RenameGringottsUsersToGringottsSettings < ActiveRecord::Migration
  def change
    rename_table :gringotts_users, :gringotts_settings
  end
end
