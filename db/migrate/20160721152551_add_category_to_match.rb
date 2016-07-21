class AddCategoryToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :category_id, :integer
  end
end
