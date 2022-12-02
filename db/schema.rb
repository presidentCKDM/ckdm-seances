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

ActiveRecord::Schema.define(version: 20150812091909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowances", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "training_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["group_id"], name: "index_allowances_on_group_id", using: :btree
    t.index ["training_session_id"], name: "index_allowances_on_training_session_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "training_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_answered",         default: false
    t.boolean  "is_confirmed",        default: false
    t.index ["training_session_id"], name: "index_invitations_on_training_session_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "training_sessions", force: :cascade do |t|
    t.text     "description"
    t.datetime "started_at"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["location_id"], name: "index_training_sessions_on_location_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
    t.boolean  "is_admin",               default: false
    t.index ["token"], name: "index_users_on_token", using: :btree
  end

  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
end
