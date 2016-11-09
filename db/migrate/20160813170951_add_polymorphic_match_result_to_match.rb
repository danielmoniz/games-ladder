class AddPolymorphicMatchResultToMatch < ActiveRecord::Migration
  def change
    remove_column :matches, :match_result_id
    add_reference :matches, :match_result, index: true, polymorphic: true
  end
end
