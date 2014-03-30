#DataFetcher: fetch data from Yahoo API
# require 'rubygems'
require 'yahoo_stock'



class DataPool::DataUpdater
  # PARAM_MAPPING1 = {
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
  PARAM_MAPPING = Property.select(:q_name).map {|property| property.q_name.to_sym}
  def self.update_per_ticker ticker, quote
    puts PARAM_MAPPING
    stock_data = Stock.find_by(ticker: ticker)
    if stock_data != nil
      update = {:ticker => ticker}
      PARAM_MAPPING.each do |key|
        update[key] = quote[key]
      end
      stock_data.update(update)
      if !stock_data.save
        raise "Stock data update fail"
      end
    else
      create = {:ticker => ticker}
      PARAM_MAPPING.each do |key|
        create[key] = quote[key]
      end
      Stock.create(create)
    end
  end

  def self.update_all
    stocks = Stock.select("ticker").distinct
    symbols = stocks.map { |stock| stock.ticker.to_s }
    quotes = YahooStock::Quote.new(:stock_symbols => symbols, :read_parameters => PARAM_MAPPING).results(:to_hash).output
    info = [symbols, quotes].transpose

    info.each do |entry|
      ticker = entry[0]
      quote = entry[1]
      update_per_ticker ticker, quote
    end
  end

  def self.update ticker
    quotes = YahooStock::Quote.new(:stock_symbols => ticker, :read_parameters => PARAM_MAPPING).results(:to_hash).output
    quote = quotes[0]
    update_per_ticker ticker, quote
  end

end
