class CreateKeys < ActiveRecord::Migration
  def self.up
    create_table :keys do |t|
      t.column :pubkey, :string, :null => false
      t.column :user_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :keys
  end
end
