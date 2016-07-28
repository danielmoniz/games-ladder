class AddFavouriteGroupToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :favourite_category_id, :integer
  end
end
