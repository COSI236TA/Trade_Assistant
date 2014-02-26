#BaseRuleTest

require 'minitest/autorun'
require 'minitest/spec'

require_relative '../base_rule'

describe BaseRule do
    it "could be initialized by a stock symbol(string)" do
        r = BaseRule.new("GOOG")
        r.must_be_instance_of BaseRule
        r.symbol.must_equal "GOOG"
    end

    it "could triggerize raw trigger" do
        r = BaseRule.new("GOOG")
        trigger = r.triggerize :up, 300
        trigger.call(300).must_equal true
    end

    it "could throw error when wrong value passed to triggerize" do
        r = BaseRule.new("GOOG")
        lambda {r.triggerize :boo, 300}.must_raise RuntimeError
    end

    it "could add trigger" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:up, 200]}
        r.add_triggers triggers
        r.triggers.size.must_equal 1
    end

    it "could add multiple triggers" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:up, 200], :volume => [:up, 100]}
        r.add_triggers triggers
        r.triggers.size.must_equal 2
    end

    it "could be ready" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:up, 200]}
        r.add_triggers(triggers)
        r.ready
        r.condition.size.must_equal 2
    end

    it "could match multiple triggers" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:up, 200], :volume => [:up, 100]}
        r.add_triggers triggers
        (1..5).each do
            if r.ready
                break
            end
        end
        r.is_met?.must_equal true
    end

    it "could match the condition against the trigger No.1" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:up, 200]}
        r.add_triggers(triggers)
        r.ready
        r.is_met?.must_equal true
    end

    it "could match the condition against the trigger No.2" do
        r = BaseRule.new("GOOG")
        triggers = {:last_trade_price_only => [:down, 200]}
        r.add_triggers(triggers)
        r.ready
        r.is_met?.must_equal false
    end
end
