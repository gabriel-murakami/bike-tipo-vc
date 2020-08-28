# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_28_152015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "district"
    t.string "city"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bikes", force: :cascade do |t|
    t.string "status"
    t.bigint "station_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["station_id"], name: "index_bikes_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "status"
    t.string "name"
    t.integer "spots_number"
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_stations_on_address_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "bike_id", null: false
    t.datetime "start_time"
    t.datetime "finish_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "start_station_id"
    t.bigint "finish_station_id"
    t.index ["bike_id"], name: "index_trips_on_bike_id"
    t.index ["finish_station_id"], name: "index_trips_on_finish_station_id"
    t.index ["start_station_id"], name: "index_trips_on_start_station_id"
  end

  add_foreign_key "bikes", "stations"
  add_foreign_key "stations", "addresses"
  add_foreign_key "trips", "bikes"
  add_foreign_key "trips", "stations", column: "finish_station_id"
  add_foreign_key "trips", "stations", column: "start_station_id"
end
