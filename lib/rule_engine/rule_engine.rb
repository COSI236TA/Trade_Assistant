#RuleEngine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

require_relative 'base_rule'

class RuleEngine::RuleEngine
    def initialize
        @rules = {}
        @results = {}
    end

    def start
        # @start_time = Time.now
        puts "%s Engine is on." % @start_time

        #Iterate all rules
        @rules.each do |symbol, raw_trigger|
            rule = BaseRule.new(symbol)
            rule.add_triggers(raw_trigger)
            rule.ready
            @results[symbol] = [rule.is_met?, rule.get_condition]
        end
        puts @results
    end

    def add_fuel symbol, indicator, up_or_down, target
        @rules[symbol] = {indicator => [up_or_down, target]}
    end

    def get_results
        @results
    end
end
