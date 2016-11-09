class CreatePingPongGames < ActiveRecord::Migration
  def change
    create_table :ping_pong_games do |t|
      t.integer :team_1_score
      t.integer :team_2_score
      t.integer :team_1_id, index: true, foreign_key: true
      t.integer :team_2_id, index: true, foreign_key: true
      t.references :ping_pong_match_result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
