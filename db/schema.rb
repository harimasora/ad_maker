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

ActiveRecord::Schema.define(version: 20160217132329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer  "attached_item_id"
    t.string   "attached_item_type"
    t.string   "attachment",                     null: false
    t.string   "original_filename"
    t.string   "content_type"
    t.string   "description"
    t.string   "state"
    t.integer  "rank",               default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "attachments", ["attached_item_type", "attached_item_id"], name: "index_attachments_on_attached_item_type_and_attached_item_id", using: :btree

  create_table "business_units", force: :cascade do |t|
    t.integer  "federation_unit_id"
    t.integer  "city_id"
    t.string   "name",                 limit: 50
    t.string   "code",                 limit: 8
    t.string   "federation_unit_name", limit: 2
    t.string   "city_name",            limit: 50
    t.string   "kind",                 limit: 10
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "code_items", force: :cascade do |t|
    t.integer  "code_table_id"
    t.string   "short_description", limit: 10
    t.string   "description",       limit: 50
    t.string   "dependent",         limit: 10
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "code_items", ["short_description"], name: "index_code_items_on_short_description", unique: true, using: :btree

  create_table "code_tables", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.string   "kind",       limit: 10
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "production_orders", force: :cascade do |t|
    t.integer  "business_unit_id"
    t.integer  "soliciting_user_id"
    t.integer  "responsible_user_id"
    t.string   "code"
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "email"
    t.string   "website"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "facebook"
    t.text     "publicity_text"
    t.text     "description"
    t.string   "youtube_video"
    t.string   "category1"
    t.string   "category2"
    t.string   "category3"
    t.string   "subcategory1"
    t.string   "subcategory2"
    t.string   "subcategory3"
    t.string   "state"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "logotype"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name",                   limit: 50
    t.string   "kind",                   limit: 10
    t.string   "situation",              limit: 10
    t.string   "state"
    t.integer  "business_unit_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
