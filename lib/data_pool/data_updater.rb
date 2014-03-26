#DataFetcher: fetch data from Yahoo API
# require 'rubygems'
require 'yahoo_stock'



class DataPool::DataUpdater
  def self.update_per_ticker ticker, quote
    stock_data = StockData.find_by(ticker: ticker)
    if stock_data != nil
      stock_data.price = quote[:last_trade_price_only]
      stock_data.volume = quote[:volume]
      stock_data.marketcap = quote[:market_capitalization]
      stock_data.last_trade_date = quote[:last_trade_date]
      stock_data.save
    else
      create = { :ticker => ticker }
      create[:price] = quote[:last_trade_price_only]
      create[:volume] = quote[:volume]
      create[:marketcap] = quote[:market_capitalization]
      create[:last_trade_date] = quote[:last_trade_date]
      StockData.create(create)
    end
  end

  def self.update_all
    stocks = Rule.select("ticker").distinct
    symbols = stocks.map { |stock| stock.ticker.to_s }
    parameters = [:last_trade_price_only, :volume, :market_capitalization, :last_trade_date]
    quotes = YahooStock::Quote.new(:stock_symbols => symbols, :read_parameters => parameters).results(:to_hash).output
    info = [symbols, quotes].transpose

    info.each do |entry|
      ticker = entry[0]
      quote = entry[1]
      update_per_ticker ticker, quote
    end
  end

  def self.update ticker
    parameters = [:last_trade_price_only, :volume, :market_capitalization, :last_trade_date]
    quotes = YahooStock::Quote.new(:stock_symbols => ticker, :read_parameters => parameters).results(:to_hash).output
    quote = quotes[0]
    update_per_ticker ticker, quote
  end

end
