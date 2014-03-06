#Rule Engine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

class RuleEngine
    def initialize
        @rules = {}
        @result = {}
    end

    def add_fuel symbol, indicator, up_or_down, target
        @rules[symbol] = {indicator => [up_or_down, target]}
    end
    def start
        @start_time = Time.now
        puts "%s Engine is on." % @start_time

        #Iterate all rules
        @rules.each do |symbol, raw_trigger|
            rule = BaseRule.new(symbol)
            rule.add_triggers(raw_trigger)
            rule.ready
            @result[symbol] = [rule.is_met?, rule.get_condition(symbol)]
        end
        @done_time = Time.now
        puts "%s Done. %.4f consumed" % @done_time, @done_time - @start_time
    end

    def get_result
        @result
    end
end
