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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151209041950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "location_id"
    t.string   "model"
    t.string   "make"
    t.string   "year"
    t.integer  "daily_price"
    t.integer  "weekly_price"
    t.integer  "store_id"
  end

  add_index "cars", ["location_id"], name: "index_cars_on_location_id", using: :btree
  add_index "cars", ["store_id"], name: "index_cars_on_store_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "car_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "days"
    t.integer  "store_id"
    t.integer  "user_id"
  end

  add_index "order_items", ["car_id"], name: "index_order_items_on_car_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["store_id"], name: "index_order_items_on_store_id", using: :btree
  add_index "order_items", ["user_id"], name: "index_order_items_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "current_status", default: "pending"
    t.integer  "total_price"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "approved",   default: false
    t.boolean  "activated",  default: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.integer  "store_id"
  end

  add_index "users", ["store_id"], name: "index_users_on_store_id", using: :btree

  add_foreign_key "cars", "locations"
  add_foreign_key "cars", "stores"
  add_foreign_key "order_items", "cars"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "stores"
  add_foreign_key "order_items", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "stores"
end
