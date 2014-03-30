class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      #absolute property
      t.string :price
      t.string :marketcap
      t.string :volume
      t.string :earnings_per_share
      t.string :p_e_ratio
      #duration day
      t.string :change
      t.string :change_in_percent
      t.string :day_low
      t.string :day_high
      #duration 52 weeks
      t.string :fifty_two_week_low
      t.string :fifty_two_week_high
      t.string :change_from_52_week_low
      t.string :percent_change_from_52_week_low
      t.string :change_from_52_week_high
      t.string :percent_change_from_52_week_high
      #duration 50 days
      t.string :moving_average_50_day
      t.string :change_from_moving_average_50_day
      t.string :percent_change_from_moving_average_50_day
      #duration 200 days
      t.string :moving_average_200_day
      t.string :change_from_moving_average_200_day
      t.string :percent_change_from_moving_average_200_day

      #time stamps
      t.string :last_trade_time

      #databse issue
      t.integer :portfolio_id
      
      t.timestamps
    end
  end
end
