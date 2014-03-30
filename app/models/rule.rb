class Rule < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio

  validates :portfolio, presence: true, length: { minimum: 1 }
  validates :property, presence: true
  validates :rel, presence: true 
  validates :target, presence: true, numericality: true

  def triggered?
    if last_triggered != nil
      history = RuleHistory.find_by(id: last_triggered)
      return history.triggered_time
    else
      return "Never"
    end
  end

  def activated?
    true
  end

  def description
    "Let me know if #{portfolio}'s #{property} goes #{rel} to #{target}"
  end
end
