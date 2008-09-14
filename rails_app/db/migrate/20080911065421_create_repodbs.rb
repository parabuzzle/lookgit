class CreateRepodbs < ActiveRecord::Migration
  def self.up
    create_table :repodbs do |t|
      t.column :name, :string, :null => false
      t.column :loc, :string, :null => false
      t.column :creator_id, :int, :null => false
      t.column :user_id, :int
      t.column :desc, :string
      t.column :requires_lead, :boolean, :default => 0
      t.column :requires_admin, :boolean, :default => 0
      t.column :requires_super_admin, :boolean, :default => 0
      t.column :is_private, :boolean, :default => 0
      t.column :is_deleted, :boolean, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :repodbs
  end
end
