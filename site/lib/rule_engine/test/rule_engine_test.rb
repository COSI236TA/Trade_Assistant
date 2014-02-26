require 'minitest/autorun'
require 'minitest/spec'
require '../rule_engine'
describe RuleEngine do
    it "has hitting_rule" do
        RuleEngine.new.respond_to?(:hitting_rule).must_equal true
    end

    it "could be started" do
        RuleEngine.new.respond_to?(:start).must_equal true
    end

end