#RuleEngine: Querying, Matching and Notifying

require 'rubygems'
require 'yahoo_stock'

require_relative 'base_rule'

class RuleEngine::RuleEngine
  def self.start
    #Update all stock information
    begin
      DataPool::DataUpdater.update_all
    rescue 
      puts "update datapool fail."
    end
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


      #To see whether the average is met
      final = false
      if rel == 'more'
        final = aggregated / stocks.size >= target
      else
        final = aggregated / stocks.size <= target
      end


      #If true, we the rule has been triggered, add it to database
      if final
        #Get the most recent history
        most_recent = rule.recent_history
        content = {rule: rule, amt: aggregated/stocks.size, triggered_time: Time.now}

        if most_recent == nil 
          #If no most recent history, create one
          most_recent = RuleHistory.new(content)
        else
          #if its last triggered time is within 10 minutes, we don't create new entry, just update the exsited one
          if Time.now - most_recent.triggered_time < 600
            most_recent.update(content)
          else
            most_recent = RuleHistory.new(content)
          end 
        end

        #if cannot save the history record sucessuflly, put the message
        if !most_recent.save
          puts "rule history save unsuccessfully"
        else
          rule.last_triggered = most_recent.id
          rule.save
        end
      end
    end
  end
end
