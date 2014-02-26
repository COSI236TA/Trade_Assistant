#Rule Engine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

class RuleEngine
    def start
        @start_time = Time.now
        puts "%s Engine is on." % @start_time
        @done_time = Time.now
        puts "%s Done. %.4f consumed" % @done_time, @done_time - @start_time
        quote = YahooStock::Quote.new(:stock_symbols => [symbol], :read_parameters => [:last_trade_date, indicator])
    end



end
