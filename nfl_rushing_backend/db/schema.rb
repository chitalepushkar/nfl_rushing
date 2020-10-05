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

ActiveRecord::Schema.define(version: 2020_09_30_042912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rushing_statistics", force: :cascade do |t|
    t.string "player_name"
    t.string "team"
    t.string "position"
    t.float "attempts_per_game"
    t.integer "attempts"
    t.integer "total_yards"
    t.float "average_yards_per_attempt"
    t.float "yards_per_game"
    t.integer "total_touchdowns"
    t.integer "longest_rush"
    t.boolean "touchdown_in_longest_rush", default: false
    t.integer "first_downs"
    t.float "first_down_percentage"
    t.integer "twenty_plus_yards_each"
    t.integer "forty_plus_yards_each"
    t.integer "fumbles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["longest_rush"], name: "index_rushing_statistics_on_longest_rush"
    t.index ["total_touchdowns"], name: "index_rushing_statistics_on_total_touchdowns"
    t.index ["total_yards"], name: "index_rushing_statistics_on_total_yards"
  end

end
