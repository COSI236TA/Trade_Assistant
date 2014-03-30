#RuleEngine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

require_relative 'base_rule'

class RuleEngine::RuleEngine
  def self.start
    #Update all stock information
    DataPool::DataUpdater.update_all
    Rule.find_each do |rule|
      ticker = rule.ticker
      property = rule.property
      rel = rule.rel
      target = rule.target
      stock_data = Stock.find_by(ticker: ticker).attributes
      result = false
      if rel == 'more'
        result = stock_data[property].to_f >= target.to_f
      else
        result = stock_data[property].to_f <= target.to_f
      end
      #If true, we the rule has been triggered, add it to database
      if result
        history = RuleHistory.new(rule_id: rule.id,
                                  amt: stock_data[property],
                                  triggered_time: stock_data.fetch("updated_at"))
        if history.save
          rule.last_triggered = history.id
          rule.save
        end
      end
    end
  end
end
