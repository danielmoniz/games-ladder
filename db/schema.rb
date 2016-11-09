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

ActiveRecord::Schema.define(version: 20160813171900) do

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_subscriptions", force: :cascade do |t|
    t.integer  "player_id",   null: false
    t.integer  "category_id", null: false
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "foosball_match_results", force: :cascade do |t|
    t.integer  "winner_id"
    t.integer  "points_per_game"
    t.string   "team_sizes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_results", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string   "score"
    t.text     "details"
    t.integer  "game_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "category_id"
    t.string   "name"
    t.integer  "match_result_id"
    t.string   "match_result_type"
  end

  add_index "matches", ["match_result_type", "match_result_id"], name: "index_matches_on_match_result_type_and_match_result_id"

  create_table "matches_teams", id: false, force: :cascade do |t|
    t.integer "team_id",  null: false
    t.integer "match_id", null: false
  end

  add_index "matches_teams", ["match_id"], name: "index_matches_teams_on_match_id"
  add_index "matches_teams", ["team_id"], name: "index_matches_teams_on_team_id"

  create_table "ping_pong_games", force: :cascade do |t|
    t.integer  "team_1_score"
    t.integer  "team_2_score"
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "ping_pong_match_result_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "ping_pong_games", ["ping_pong_match_result_id"], name: "index_ping_pong_games_on_ping_pong_match_result_id"
  add_index "ping_pong_games", ["team_1_id"], name: "index_ping_pong_games_on_team_1_id"
  add_index "ping_pong_games", ["team_2_id"], name: "index_ping_pong_games_on_team_2_id"

  create_table "ping_pong_match_results", force: :cascade do |t|
    t.integer  "winner_id"
    t.integer  "points_per_game"
    t.string   "team_sizes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "favourite_game_id"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "favourite_category_id"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true
  add_index "players", ["remember_me_token"], name: "index_players_on_remember_me_token"

  create_table "players_teams", id: false, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id",   null: false
  end

  add_index "players_teams", ["player_id"], name: "index_players_teams_on_player_id"
  add_index "players_teams", ["team_id"], name: "index_players_teams_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

end
