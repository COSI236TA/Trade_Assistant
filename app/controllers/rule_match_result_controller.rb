class RuleMatchResultController < ApplicationController
    # include SessionsHelper

    def new_rule
    end
    
    def rule_query
        symbol = params[:symbol]
        indicator = params[:indicator].to_sym
        up_or_down = params[:up_or_down].to_sym
        target = params[:target].to_i
        rule_engine = RuleEngine::RuleEngine.new
        rule_engine.add_fuel(symbol, indicator, up_or_down, target)
        rule_engine.start
        @results = rule_engine.get_results
    end
end
