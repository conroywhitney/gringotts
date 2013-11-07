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

ActiveRecord::Schema.define(version: 20131107005202) do

  create_table "gringotts_attempts", force: true do |t|
    t.integer  "vault_id",                      null: false
    t.string   "code_received",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "successful",    default: false, null: false
  end

  add_index "gringotts_attempts", ["vault_id"], name: "index_gringotts_attempts_on_vault_id"

  create_table "gringotts_codes", force: true do |t|
    t.integer  "vault_id",   null: false
    t.string   "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at"
  end

  add_index "gringotts_codes", ["vault_id"], name: "index_gringotts_codes_on_vault_id"

  create_table "gringotts_deliveries", force: true do |t|
    t.integer  "vault_id",       null: false
    t.integer  "code_id",        null: false
    t.string   "strategy_class", null: false
    t.string   "phone_number",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delivered_at"
    t.string   "error_message"
  end

  add_index "gringotts_deliveries", ["vault_id"], name: "index_gringotts_deliveries_on_vault_id"

  create_table "gringotts_settings", force: true do |t|
    t.integer  "vault_id",                     null: false
    t.boolean  "active",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
  end

  add_index "gringotts_settings", ["vault_id"], name: "index_gringotts_settings_on_vault_id", unique: true

  create_table "gringotts_vaults", force: true do |t|
    t.integer  "owner_id",       null: false
    t.datetime "locked_at"
    t.string   "owner_type"
    t.datetime "prompt_seen_at"
    t.datetime "confirmed_at"
  end

  add_index "gringotts_vaults", ["owner_id"], name: "index_gringotts_vaults_on_owner_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
