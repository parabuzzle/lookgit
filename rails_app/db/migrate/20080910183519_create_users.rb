class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :username, :string, :null => false
      t.column :password, :string, :null => false
      t.column :password_confirmation, :string, :null => false
      t.column :realname, :string
      t.column :email, :string, :null => false
      t.column :is_super_admin, :boolean, :default => 0
      t.column :is_admin, :boolean, :default => 0
      t.column :is_lead, :boolean, :default => 0
      t.timestamps
    end
    execute "INSERT INTO users (username, password, password_confirmation, email, is_super_admin, is_admin, is_lead) VALUES('admin', 'admin', 'admin', 'admin@admin.com', 1, 1, 1)"
  end

  def self.down
    drop_table :users
  end
end
