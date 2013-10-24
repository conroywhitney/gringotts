class CreateGringottsVaults < ActiveRecord::Migration
  def change
    create_table :gringotts_vaults do |t|
      t.integer :user_id, :null => false
    end
    
    add_index :gringotts_vaults, :user_id, :unique => true
  end
end
