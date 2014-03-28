class Rule < ActiveRecord::Base
  belongs_to :user

  validates :ticker, presence: true, length: { minimum: 1 }
  validates :property, presence: true
  validates :rel, presence: true 
  validates :target, presence: true, numericality: true

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
