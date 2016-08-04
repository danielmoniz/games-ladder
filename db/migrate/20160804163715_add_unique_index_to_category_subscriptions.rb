class AddUniqueIndexToCategorySubscriptions < ActiveRecord::Migration
  def change
    add_index :categories_players, [ :category_id, :player_id ], :unique => true, :name => 'by_category_and_player'
  end
end
