class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.column :user_id, :int
      t.column :repodb_id, :int
      t.column :member_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
