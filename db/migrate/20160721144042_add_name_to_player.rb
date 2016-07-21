class AddNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :name, :string
    add_column :players, :favourite_game, :string
  end
end
