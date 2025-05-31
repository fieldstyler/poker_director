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

ActiveRecord::Schema[8.0].define(version: 2025_05_31_160119) do
  create_table "game_players", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "player_id", null: false
    t.integer "points", default: 0
    t.integer "knockouts", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "eliminated", default: false
    t.integer "session_points", default: 0
    t.integer "session_knockouts", default: 0
    t.boolean "bounty", default: false
    t.integer "eliminated_by_id"
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["player_id"], name: "index_game_players_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "buy_in"
    t.string "starting_stack"
    t.string "round_length"
    t.string "places_paid"
    t.boolean "knockouts"
    t.string "level_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rebuys"
    t.integer "league_id"
    t.boolean "completed", default: false
    t.integer "player_count"
    t.index ["league_id"], name: "index_games_on_league_id"
  end

  create_table "league_players", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season_points", default: 0
    t.integer "season_knockouts", default: 0
    t.index ["league_id"], name: "index_league_players_on_league_id"
    t.index ["player_id"], name: "index_league_players_on_player_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_sessions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "sb"
    t.string "bb"
    t.string "ante"
    t.string "length"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "break"
    t.string "break_length"
    t.index ["game_id"], name: "index_levels_on_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
  add_foreign_key "games", "leagues"
  add_foreign_key "league_players", "leagues"
  add_foreign_key "league_players", "players"
  add_foreign_key "levels", "games"
end
