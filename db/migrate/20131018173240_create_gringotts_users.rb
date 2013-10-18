class CreateGringottsUsers < ActiveRecord::Migration
  def change
    create_table :gringotts_users do |t|
      t.integer    :user_id, :null => false
      t.boolean    :active,  :null => false,  :default => false
      t.timestamps
    end
  end
end
