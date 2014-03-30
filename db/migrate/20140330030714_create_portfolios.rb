class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.integer :stock_id
      t.timestamps
    end
  end
end
