class RenameUserIdColumnsToVaultId < ActiveRecord::Migration
  def change
    remove_index  :gringotts_settings, :user_id
    rename_column :gringotts_settings, :user_id,  :vault_id
    add_index     :gringotts_settings, :vault_id, unique: true
    
    remove_index  :gringotts_attempts, :user_id
    rename_column :gringotts_attempts, :user_id,  :vault_id
    add_index     :gringotts_attempts, :vault_id, unique: false
  end
end
