class DataPool::DataPool
  #CONFIGURATION
  DATA_SOURCE = "db"
  # DATA_SOURCE = "redis"

  def self.query ticker
    if DATA_SOURCE == 'db'
      stock_data = Stock.find_by(ticker: ticker)
      ret = nil
      if stock_data == nil
        puts "Raw, need update"
        DataPool::DataUpdater.update ticker
        stock_data = Stock.find_by(ticker: ticker)
      end
      ret = stock_data.attributes if stock_data != nil
    end
    return ret
  end
end
