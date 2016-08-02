class CreatePlayersCategoriesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :players, :categories do |t|
      t.index :player_id
      t.index :category_id
    end
  end
end
