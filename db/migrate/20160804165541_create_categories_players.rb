class CreateCategoriesPlayers < ActiveRecord::Migration
  def change
    create_table :categories_players, force: :cascade do |t|
      t.integer "player_id",   null: false
      t.integer "category_id", null: false
      t.timestamps null: false
      t.string 'status'
    end
  end
end
