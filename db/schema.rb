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

ActiveRecord::Schema.define(version: 2019_08_27_124052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instruments", force: :cascade do |t|
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "open"
    t.string "high"
    t.string "low"
    t.string "close"
    t.string "volume"
    t.string "vwap"
    t.integer "end_time"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instrument_id"
    t.index ["instrument_id"], name: "index_prices_on_instrument_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.string "data", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instrument_id"
    t.string "time_key"
    t.index ["instrument_id"], name: "index_tickers_on_instrument_id"
  end

  add_foreign_key "prices", "instruments"
  add_foreign_key "tickers", "instruments"
end
