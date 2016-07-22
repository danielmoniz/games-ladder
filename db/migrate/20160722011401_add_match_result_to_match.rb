class AddMatchResultToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :match_result_id, :integer
  end
end
