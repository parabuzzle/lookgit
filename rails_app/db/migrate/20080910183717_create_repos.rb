class CreateRepos < ActiveRecord::Migration
  def self.up
    create_table :repos do |t|
      t.column :name, :string, :null => false
      t.column :loc, :string, :null => false
      t.column :creator_id, :int, :null => false
      t.column :owner_id, :int, :null => false
      t.column :requires_lead, :boolean, :default => 0
      t.column :requires_admin, :boolean, :default => 0
      t.column :requires_super_admin, :boolean, :default => 0
      t.column :is_public, :boolean, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :repos
  end
end
