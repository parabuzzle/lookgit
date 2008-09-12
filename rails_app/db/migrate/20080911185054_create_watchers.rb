class CreateWatchers < ActiveRecord::Migration
  def self.up
    create_table :watchers do |t|
      t.column :user_id, :int
      t.column :repo_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :watchers
  end
end
