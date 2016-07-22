class CreateMatchResults < ActiveRecord::Migration
  def change
    create_table :match_results do |t|
      t.integer :match_id
      t.integer :winner_id

      t.timestamps null: false
    end
  end
end
