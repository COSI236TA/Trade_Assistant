class CreateRuleHistories < ActiveRecord::Migration
  def change
    create_table :rule_histories do |t|
      t.belongs_to :rule
      t.integer :stock_id
      t.string :amt
      t.datetime :triggered_time
      t.timestamps
    end
  end
end
