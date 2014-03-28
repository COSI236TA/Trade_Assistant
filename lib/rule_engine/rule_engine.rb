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
        @rules.each do |ticker, raw_trigger|
            rule = BaseRule.new(ticker)
            rule.add_triggers(raw_trigger)
            rule.ready
            @results[ticker] = [rule.is_met?, rule.get_condition]
        end
        puts @results
    end

    def add_fuel ticker, property, rel, target
        @rules[ticker] = {property => [rel, target]}
    end

    def get_results
        @results
    end
    def self.start
        #Update all stock information
        DataPool::DataUpdater.update_all
        Rule.find_each do |rule|
            ticker = rule.ticker
            property = rule.property
            rel = rule.rel
            target = rule.target
            stock_data = StockData.find_by(ticker: ticker).attributes
            result = false
            if rel == 'up'
               result = stock_data[property].to_f >= target.to_f 
            else
               result = stock_data[property].to_f <= target.to_f 
            end
            #If true, we the rule has been triggered, add it to database
            if result
                history = RuleHistory.new(rule_id: rule.id, amt: stock_data[property])
                if history.save
                    rule.last_trigger = history.id
                    rule.save
                end
            end 

        end
    end
end
