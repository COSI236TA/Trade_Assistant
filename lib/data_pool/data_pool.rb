class DataPool::DataPool
    #CONFIGURATION
    DATA_SOURCE = "yahoo"
    # DATA_SOURCE = "redis"


    def self.query symbol, triggers
        if DATA_SOURCE == "yahoo"
            return YahooStock::Quote.new(:stock_symbols => symbol, :read_parameters => triggers.keys).results(:to_hash).output[0]
        else
            return nil
        end
    end
end
