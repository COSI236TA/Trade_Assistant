class DataPool::DataPool
    #CONFIGURATION
    DATA_SOURCE = "db"
    # DATA_SOURCE = "redis"

    def self.query ticker
        if DATA_SOURCE == 'db'
            stock_data = StockData.find_by(ticker: ticker)
            if stock_data == nil
                DataPool::DataUpdater.update ticker
                stock_data = StockData.find_by(ticker: ticker)
            end
            return stock_data.attributes
        else
            return nil
        end
    end
end
