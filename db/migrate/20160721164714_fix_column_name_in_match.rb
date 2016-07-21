class FixColumnNameInMatch < ActiveRecord::Migration
  def change
    rename_column :matches, :game, :game_id
  end
end
