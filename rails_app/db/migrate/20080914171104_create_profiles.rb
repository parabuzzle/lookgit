class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.column :user_id, :int
      t.column :about, :text
      t.column :homephone, :string
      t.column :workphone, :string
      t.column :cellphone, :scring
      t.column :address, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :pubemail, :string
      t.column :quote, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
