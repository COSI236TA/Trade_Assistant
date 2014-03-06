class RuleMatchResultController < ApplicationController
    def new_rule
    end
    
    def rule_query
        symbol = params[:symbol]
        indicator = params[:indicator].to_sym
        up_or_down = params[:up_or_down].to_sym
        target = params[:target].to_i
        lap = RuleEngine::RuleEngine.new
        lap.add_fuel(symbol, indicator, up_or_down, target)
        lap.start
        @results = lap.get_results
    end
end
