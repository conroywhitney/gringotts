class MakeOwnerIndexOnGringottsVaultsPolymorphic < ActiveRecord::Migration
  def change
    remove_index "gringotts_vaults", name: "index_gringotts_vaults_on_owner_id"
    add_index "gringotts_vaults", ["owner_id", "owner_type"], name: "index_gringotts_vaults_on_owner_id_and_owner_type", unique: true
  end
end
