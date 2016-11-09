class InitSchema < ActiveRecord::Migration
  def up
    
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
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
      t.integer  "category_id"
      t.integer  "match_result_id"
      t.string   "name"
    end
    
    create_table "matches_teams", id: false, force: :cascade do |t|
      t.integer "team_id",  null: false
      t.integer "match_id", null: false
    end
    
    add_index "matches_teams", ["match_id"], name: "index_matches_teams_on_match_id"
    add_index "matches_teams", ["team_id"], name: "index_matches_teams_on_team_id"
    
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

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
