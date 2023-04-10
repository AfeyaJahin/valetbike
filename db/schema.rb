# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_10_181105) do
  create_table "bikes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "identifier"
    t.integer "current_station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_station_identifier"
    t.integer "station_id"
  end

  create_table "bikes_rentings", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "renting_id", null: false
    t.bigint "bike_id", null: false
    t.index ["bike_id", "renting_id"], name: "index_bikes_rentings_on_bike_id_and_renting_id"
    t.index ["renting_id", "bike_id"], name: "index_bikes_rentings_on_renting_id_and_bike_id"
  end

  create_table "cards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cardholder_name"
    t.bigint "card_number"
    t.date "expiration_date"
    t.integer "cvv"
    t.float "card_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bike_id"
    t.string "current_station_name"
    t.integer "current_station_id"
    t.datetime "startTime"
    t.datetime "endTime"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentings_stations", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "renting_id", null: false
    t.bigint "station_id", null: false
    t.index ["renting_id", "station_id"], name: "index_rentings_stations_on_renting_id_and_station_id"
    t.index ["station_id", "renting_id"], name: "index_rentings_stations_on_station_id_and_renting_id"
  end

  create_table "services", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "bike_number"
    t.string "bike_station"
    t.string "additional_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "identifier"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "has_kiosk"
    t.integer "needs_maintenance"
    t.integer "dock_count"
    t.integer "docked_bike_count"
  end

end
