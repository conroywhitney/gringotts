class AddConfirmedAtToGringottsVaults < ActiveRecord::Migration
  def change
    add_column :gringotts_vaults, :confirmed_at, :datetime, null: true
  end
end
