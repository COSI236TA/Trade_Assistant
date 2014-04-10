if ActiveRecord::Base.connection.tables.include?('properties')
  # PARAM_MAPPING = {
  #   :price => :last_trade_price_only,
  #   :marketcap => :market_capitalization,
  #   :volume => :volume,
  #   :earnings_per_share => :earnings_per_share,
  #   :p_e_ratio => :p_e_ratio,
  #   :change => :change,
  #   :change_in_percent => :change_in_percent,
  #   :day_low => :day_low,
  #   :day_high => :day_high,
  #   :fifty_two_week_low => :fifty_two_week_low,
  #   :fifty_two_week_high => :fifty_two_week_high,
  #   :change_from_52_week_low => :change_from_52_week_low,
  #   :change_from_52_week_high => :change_from_52_week_high,
  #   :percent_change_from_52_week_low => :percent_change_from_52_week_low,
  #   :percent_change_from_52_week_high => :percent_change_from_52_week_high,
  #   :moving_average_50_day => :fifty_day_moving_average,
  #   :moving_average_200_day => :two_hundred_day_moving_average,
  #   :change_from_moving_average_50_day => :change_from_50_day_moving_average,
  #   :change_from_moving_average_200_day => :change_from_200_day_moving_average,
  #   :percent_change_from_moving_average_50_day => :percent_change_from_50_day_moving_average,
  #   :percent_change_from_moving_average_200_day => :percent_change_from_200_day_moving_average,
  #   :last_trade_time => :last_trade_with_time
  # }
  Property.create(p_id: 1, q_name: "last_trade_price_only", d_name: "price")
  Property.create(p_id: 2, q_name: "market_capitalization", d_name: "market capitalization")
  Property.create(p_id: 3, q_name: "volume", d_name: "volume")
  Property.create(p_id: 4, q_name: "earnings_per_share", d_name: "earnings per share")
  Property.create(p_id: 5, q_name: "p_e_ratio", d_name: "P/E")
  Property.create(p_id: 6, q_name: "change", d_name: "daily change")
  Property.create(p_id: 7, q_name: "change_in_percent", d_name: "daily change percentage")
  Property.create(p_id: 8, q_name: "day_low", d_name: "day low")
  Property.create(p_id: 9, q_name: "day_high", d_name: "day high")
  Property.create(p_id: 10, q_name: "fifty_two_week_low", d_name: "lowest price in past 52 weeks")
  Property.create(p_id: 11, q_name: "fifty_two_week_high", d_name: "highest price in past 52 weeks")
  Property.create(p_id: 12, q_name: "change_from_52_week_low", 
    d_name: "change of price compared to the lowest in past 52 weeks")
  Property.create(p_id: 13, q_name: "change_from_52_week_high", 
    d_name: "change of price compared to the highest in past 52 weeks")
  Property.create(p_id: 14, q_name: "percent_change_from_52_week_low", 
    d_name: "percentage change of price compared to the lowest in past 52 weeks")
  Property.create(p_id: 15, q_name: "percent_change_from_52_week_high", 
    d_name: "percentage change of price compared to the highest in past 52 weeks")
  Property.create(p_id: 16, q_name: "fifty_day_moving_average", d_name: "50-day moving average")
  Property.create(p_id: 17, q_name: "two_hundred_day_moving_average", d_name: "200-day moving average")
  Property.create(p_id: 18, q_name: "change_from_50_day_moving_average", d_name: "change from 50-day moving average")
  Property.create(p_id: 19, q_name: "change_from_200_day_moving_average", d_name: "change from 200-day moving average")
  Property.create(p_id: 20, q_name: "percent_change_from_50_day_moving_average", 
    d_name: "percentage change from 50-day moving average")
  Property.create(p_id: 21, q_name: "percent_change_from_200_day_moving_average", 
    d_name: "percentage change from 200-day moving average")
  Property.create(p_id: 22, q_name: "last_trade_time", d_name: "last trade time")
  Property.create(p_id: 23, q_name: "last_trade_date", d_name: "last trade date")

end
