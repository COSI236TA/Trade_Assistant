class CreateStockData < ActiveRecord::Migration
  def change
    create_table :stock_data do |t|
      t.string :symbol
      t.float :price
      t.float :marketcap
      t.float :volume
      t.time :last_update_time

      t.timestamps
    end
  end
end
