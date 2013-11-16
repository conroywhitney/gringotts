class MakeOwnerIndexOnGringottsVaultsPolymorphic < ActiveRecord::Migration
  def change
    add_index "gringotts_vaults", ["owner_id", "owner_type"], name: "index_gringotts_vaults_on_owner_id_and_owner_type", unique: true
  end
end
