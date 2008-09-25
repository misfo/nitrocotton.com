# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 12) do

  create_table "comments", :force => true do |t|
    t.integer  "shirt_id"
    t.string   "name"
    t.string   "url"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "original_url"
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shirt_id"
  end

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "labels_shirts", :id => false, :force => true do |t|
    t.integer "label_id"
    t.integer "shirt_id"
  end

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "homepage_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shirts", :force => true do |t|
    t.string   "name"
    t.string   "merchant_url"
    t.text     "description"
    t.decimal  "min_price"
    t.decimal  "max_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "merchant_id"
    t.text     "text"
  end

  add_index "shirts", ["merchant_url"], :name => "index_shirts_on_merchant_url", :unique => true

  create_table "users", :force => true do |t|
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["ip_address"], :name => "index_users_on_ip_address", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "shirt_id",   :null => false
    t.integer  "vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id", "shirt_id"], :name => "index_votes_on_user_id_and_shirt_id", :unique => true

end
