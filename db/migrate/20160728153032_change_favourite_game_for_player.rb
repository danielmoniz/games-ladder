class ChangeFavouriteGameForPlayer < ActiveRecord::Migration
  def self.up
    rename_column :players, :favourite_game, :favourite_game_id
    change_column :players, :favourite_game_id, :integer
  end

  def self.down
    rename_column :players, :favourite_game_id, :favourite_game
    change_column :players, :favourite_game, :string
  end
end
