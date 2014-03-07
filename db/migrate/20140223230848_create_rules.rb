class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :stock_id
      t.integer :indicator_id
      t.integer :up_or_down
      t.integer :margin

      t.timestamps
    end
  end
end
