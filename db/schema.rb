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

ActiveRecord::Schema.define(version: 20141202001420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string   "country_code"
    t.integer  "panel_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["country_code"], name: "index_countries_on_country_code", using: :btree
  add_index "countries", ["panel_provider_id"], name: "index_countries_on_panel_provider_id", using: :btree

  create_table "location_groups", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "location_groups", ["country_id"], name: "index_location_groups_on_country_id", using: :btree
  add_index "location_groups", ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id", using: :btree

  create_table "location_groups_locations", id: false, force: true do |t|
    t.integer "location_id"
    t.integer "location_group_id"
  end

  add_index "location_groups_locations", ["location_group_id"], name: "index_location_groups_locations_on_location_group_id", using: :btree
  add_index "location_groups_locations", ["location_id"], name: "index_location_groups_locations_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "external_id"
    t.string   "secret_code"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["country_id"], name: "index_locations_on_country_id", using: :btree

  create_table "panel_providers", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "panel_providers", ["code"], name: "index_panel_providers_on_code", using: :btree

  create_table "target_groups", force: true do |t|
    t.string   "name"
    t.string   "external_id"
    t.integer  "parent_id"
    t.string   "secret_code"
    t.integer  "country_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "target_groups", ["country_id"], name: "index_target_groups_on_country_id", using: :btree
  add_index "target_groups", ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id", using: :btree
  add_index "target_groups", ["parent_id"], name: "index_target_groups_on_parent_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
