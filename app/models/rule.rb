class Rule < ActiveRecord::Base
  belongs_to :user
  def last_triggered
    rule_engine = RuleEngine::RuleEngine.new
    rule_engine.add_fuel(ticker, property, rel, target)
    rule_engine.start
    rule_engine.get_results[ticker][0]
  end

  def activated?
    true
  end

  def description
    "Let me know if #{ticker}'s #{property} goes #{rel} to #{target}"
  end
end
