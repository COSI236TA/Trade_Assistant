class RuleMatchResultController < ApplicationController
    def new_rule
    end
    
    def rule_query
        symbol = params[:symbol]
        indicator = params[:indicator].to_sym
        up_or_down = params[:up_or_down].to_sym
        target = params[:target].to_i
        rule_engine = Lap.new
        rule_engine.add_fuel(symbol, indicator, up_or_down, target)
        rule_engine.start

        @result = rule_engine.get_result
    end
end
