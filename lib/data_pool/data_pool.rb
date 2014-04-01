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


  #string to float

  def string_to_float(s1)
  
    last_char = s1[-1,1]
  
      if last_char== "K"
        output = s1.chop + "000"
    
      elsif last_char == "M"
        output= s1.chop + "000000"
    
      elsif last_char == "B"
        output = s1.chop + "000000000"
      else
        puts "invalid entry"
      end
    return output.to_f
  end

end
