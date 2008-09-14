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

ActiveRecord::Schema.define(:version => 20080914052133) do

  create_table "events", :force => true do |t|
    t.string   "username"
    t.integer  "user_id"
    t.string   "event"
    t.string   "reponame"
    t.integer  "repodb_id"
    t.boolean  "is_private",   :default => false
    t.boolean  "is_deleted",   :default => false
    t.boolean  "is_processed", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys", :force => true do |t|
    t.string   "pubkey",     :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repodb_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repodbs", :force => true do |t|
    t.string   "name",                                    :null => false
    t.string   "loc",                                     :null => false
    t.integer  "creator_id",                              :null => false
    t.integer  "user_id"
    t.string   "desc"
    t.boolean  "requires_lead",        :default => false
    t.boolean  "requires_admin",       :default => false
    t.boolean  "requires_super_admin", :default => false
    t.boolean  "is_private",           :default => false
    t.boolean  "is_deleted",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repodbs_watchers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repodb_id"
    t.integer  "watcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                 :null => false
    t.string   "password",                                 :null => false
    t.string   "password_confirmation",                    :null => false
    t.string   "realname"
    t.string   "email",                                    :null => false
    t.boolean  "is_super_admin",        :default => false
    t.boolean  "is_admin",              :default => false
    t.boolean  "is_lead",               :default => false
    t.boolean  "is_deleted",            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "watchers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repodb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
