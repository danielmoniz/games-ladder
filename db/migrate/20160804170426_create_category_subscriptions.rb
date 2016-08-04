class CreateCategorySubscriptions < ActiveRecord::Migration
  def change
    create_table :category_subscriptions do |t|
      t.integer "player_id",   null: false
      t.integer "category_id", null: false
      t.string 'status'
      t.timestamps null: false
    end

    drop_table :categories_players
  end
end
