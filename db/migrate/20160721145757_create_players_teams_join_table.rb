class CreatePlayersTeamsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :players, :teams do |t|
      t.index :player_id
      t.index :team_id
    end
  end
end
