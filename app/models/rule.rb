class Rule < ActiveRecord::Base
  belongs_to :user
  def last_triggered
    rule_engine = RuleEngine::RuleEngine.new
    rule_engine.add_fuel(get_ticker, get_property, get_rel, get_target)
    rule_engine.start
    rule_engine.get_results[ticker][0]
  end

  def activated?
    true
  end

  def description
    "Let me know if #{ticker}'s #{property} goes #{rel} to #{target}"
  end
  private
  def get_ticker
    self[:ticker]
  end

  def get_property
    self[:property].to_sym
  end

  def get_rel
    self[:rel].to_sym
  end

  def get_target
    self[:target]
  end
end
