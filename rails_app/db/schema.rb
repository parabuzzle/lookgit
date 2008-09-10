# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080910191428) do

  create_table "keys", :force => true do |t|
    t.string   "pubkey",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repos", :force => true do |t|
    t.string   "name",                                    :null => false
    t.string   "loc",                                     :null => false
    t.integer  "creator_id",                              :null => false
    t.integer  "owner_id",                                :null => false
    t.boolean  "requires_lead",        :default => false
    t.boolean  "requires_admin",       :default => false
    t.boolean  "requires_super_admin", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                          :null => false
    t.string   "password",                          :null => false
    t.string   "realname"
    t.string   "email",                             :null => false
    t.boolean  "is_super_admin", :default => false
    t.boolean  "is_admin",       :default => false
    t.boolean  "is_lead",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end