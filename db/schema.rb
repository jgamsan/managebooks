# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120219190711) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "status",                                :default => false
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "admins", %W(email), :name => "index_admins_on_email", :unique => true
  add_index "admins", %W(reset_password_token), :name => "index_admins_on_reset_password_token", :unique => true

  create_table "bids", :force => true do |t|
    t.integer  "store_id"
    t.string   "name"
    t.date     "init"
    t.date     "finish"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "oferta"
  end

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.date     "day"
    t.integer  "interval_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "who"
  end

  create_table "business_rules", :force => true do |t|
    t.integer  "store_id"
    t.integer  "booksmin",                                 :default => 0
    t.integer  "booksmax",                                 :default => 0
    t.decimal  "rule",       :precision => 6, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "extras", :force => true do |t|
    t.integer  "book_id"
    t.integer  "service_extra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intervals", :force => true do |t|
    t.integer  "resort_id"
    t.time     "init"
    t.time     "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.integer  "resort_id"
    t.integer  "service_extra_id"
    t.boolean  "enable",           :default => true
    t.boolean  "hduration",        :default => true
    t.boolean  "hcost",            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_galleries", :force => true do |t|
    t.integer  "store_id"
    t.string   "photo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resorts", :force => true do |t|
    t.string   "name"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost",       :precision => 6, :scale => 2, :default => 0.0
  end

  create_table "service_extras", :force => true do |t|
    t.string   "name"
    t.integer  "lasting",                                  :default => 0
    t.decimal  "cost",       :precision => 6, :scale => 2, :default => 0.0
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "zip_code"
    t.integer  "town_id"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "email"
    t.integer  "admin_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "gmaps"
    t.string   "logo"
  end

  create_table "towns", :force => true do |t|
    t.integer  "province_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
