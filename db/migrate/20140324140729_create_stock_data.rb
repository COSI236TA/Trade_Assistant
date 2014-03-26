class CreateStockData < ActiveRecord::Migration
  def change
    create_table :stock_data do |t|
      t.string :ticker
      t.string :price
      t.string :marketcap
      t.string :volume
      t.string :last_trade_date

      t.timestamps
    end
  end
end
