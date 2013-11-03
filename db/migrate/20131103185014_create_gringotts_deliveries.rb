class CreateGringottsDeliveries < ActiveRecord::Migration
  def change
    create_table :gringotts_deliveries do |t|
      t.integer :vault_id,       null: false
      t.integer :code_id,        null: false
      t.string  :strategy_class, null: false
      t.string  :phone_number,   null: false
      t.timestamps
    end
    
    add_index :gringotts_deliveries, :vault_id, unique: false
  end
end
