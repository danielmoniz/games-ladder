class CreateTeamsMatchesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :teams, :matches do |t|
      t.index :team_id
      t.index :match_id
    end
  end
end
