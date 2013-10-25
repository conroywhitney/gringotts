class CreateGringottsCodes < ActiveRecord::Migration
  def change
    create_table :gringotts_codes do |t|
      t.integer    :vault_id,  null: false
      t.string     :value,     null: false
      t.timestamps
    end
    
    add_index  :gringotts_codes, :vault_id, unique: false
  end
end
