class AddLockedAtToGringottsVaults < ActiveRecord::Migration
  def change
    add_column :gringotts_vaults, :locked_at, :datetime, :null => true
  end
end
