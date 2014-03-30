#RuleEngine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

require_relative 'base_rule'

class RuleEngine::RuleEngine
  def self.start
    #Update all stock information
    DataPool::DataUpdater.update_all
    Rule.find_each do |rule|
      #portfolio of the rule
      portfolio = rule.portfolio

      #stocks of the portfolio
      stocks = portfolio.stocks

      #property of the rule
      property = rule.property.q_name

      #relationship of the rule
      rel = rule.rel

      #target of the rule
      target = rule.target.to_f

      #aggregated amount of the property 
      aggregated = 0.0

      #parse the rule stock by stock
      stocks.each do |stock|
        aggregated += stock.attributes[property].to_f
      end

      puts aggregated

      #To see whether the average is met
      final = false
      if rel == 'more'
        final = aggregated / stocks.size >= target
      else
        final = aggregated / stocks.size <= target
      end

      #If true, we the rule has been triggered, add it to database
      if final
        history = RuleHistory.new(rule: rule,
                                  amt: aggregated/stocks.size,
                                  triggered_time: Time.now)
        if history.save
          rule.last_triggered = history.id
          rule.save
        end
      end
    end
  end
end
