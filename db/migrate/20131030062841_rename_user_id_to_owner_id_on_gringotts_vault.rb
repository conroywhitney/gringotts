class RenameUserIdToOwnerIdOnGringottsVault < ActiveRecord::Migration
  def change
    rename_column :gringotts_vaults, :user_id, :owner_id
    add_column    :gringotts_vaults, :owner_type, :string
  end
end
