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

ActiveRecord::Schema.define(version: 2019_08_31_164005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instruments", force: :cascade do |t|
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "instrument_id"
    t.string "status", null: false
    t.boolean "profitable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_positions_on_instrument_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.string "data", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instrument_id"
    t.string "time_key"
    t.index ["instrument_id"], name: "index_tickers_on_instrument_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "position_id"
    t.string "type", null: false
    t.string "order_type", null: false
    t.string "volume", null: false
    t.string "price", null: false
    t.string "filled_at_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_trades_on_instrument_id"
    t.index ["position_id"], name: "index_trades_on_position_id"
  end

  add_foreign_key "tickers", "instruments"
end
