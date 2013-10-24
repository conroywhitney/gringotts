class CreateGringottsAttempts < ActiveRecord::Migration
  def change
    create_table :gringotts_attempts do |t|
      t.integer  :user_id,       :null => false
      t.string   :code_received, :null => false
      t.timestamps
    end
    
    add_index :gringotts_attempts, :user_id, :unique => true
  end
end
