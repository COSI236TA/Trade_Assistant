class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      #absolute property
      t.string :last_trade_price_only
      t.string :market_capitalization
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
      t.string :fifty_day_moving_average
      t.string :change_from_50_day_moving_average
      t.string :percent_change_from_50_day_moving_average
      #duration 200 days
      t.string :two_hundred_day_moving_average
      t.string :change_from_200_day_moving_average
      t.string :percent_change_from_200_day_moving_average

      #time stamps
      t.string :last_trade_time
      t.string :last_trade_date

      t.timestamps
    end
  end
end
