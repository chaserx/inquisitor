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

ActiveRecord::Schema.define(version: 20150303044711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "mobile_phones", force: :cascade do |t|
    t.string   "number"
    t.string   "auth_code"
    t.boolean  "verified"
    t.boolean  "disabled"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mobile_phones", ["user_id"], name: "index_mobile_phones_on_user_id", using: :btree

  create_table "sms", force: :cascade do |t|
    t.string   "sender"
    t.string   "receiver"
    t.string   "body"
    t.string   "message_sid"
    t.integer  "mobile_phone_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "sms", ["mobile_phone_id"], name: "index_sms_on_mobile_phone_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "settings",         default: {}, null: false
    t.string   "gravatar_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
