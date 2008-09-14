class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :username, :string
      t.column :user_id, :int
      t.column :event, :string
      t.column :reponame, :string
      t.column :repodb_id, :int
      t.column :is_private, :boolean, :default => 0
      t.column :is_deleted, :boolean, :default => 0
      t.column :is_processed, :boolean, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
