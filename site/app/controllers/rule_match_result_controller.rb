class RuleMatchResultController < ApplicationController
    def new
    end
    
    def rule_query
        indicator = params[:indicator]
        symbol = params[:symbol]
        target = params[:target]
        up_or_down = params[:up_or_down]
        stock_info = {symbol => [indicator, up_or_down, target]}
        rule_engine = RuleEngine.new
        rule_engine.add_fuel(stock_info)
        rule_engine.start

        @result = rule_engine.get_result
    end
end
