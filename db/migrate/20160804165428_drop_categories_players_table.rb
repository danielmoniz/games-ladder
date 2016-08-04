class DropCategoriesPlayersTable < ActiveRecord::Migration
  def change
    drop_table :categories_players
  end
end
