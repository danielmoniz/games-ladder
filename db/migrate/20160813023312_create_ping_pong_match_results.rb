class CreatePingPongMatchResults < ActiveRecord::Migration
  def change
    create_table :ping_pong_match_results do |t|
      t.integer :winner_id
      t.integer :points_per_game
      t.string :team_sizes

      t.timestamps null: false
    end
  end
end
