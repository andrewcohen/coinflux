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

ActiveRecord::Schema.define(version: 20131215062253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "depth_tickers", force: true do |t|
    t.integer  "price",        limit: 8
    t.integer  "volume",       limit: 8
    t.integer  "type_num"
    t.string   "type_str"
    t.string   "item"
    t.string   "currency"
    t.integer  "total_volume", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticker_prices", force: true do |t|
    t.integer  "high"
    t.integer  "low"
    t.integer  "avg"
    t.integer  "vwap"
    t.integer  "last_local"
    t.integer  "last_orig"
    t.integer  "last"
    t.integer  "buy"
    t.integer  "sell"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", force: true do |t|
    t.integer  "cash_value"
    t.integer  "btc_value"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", using: :btree

end
