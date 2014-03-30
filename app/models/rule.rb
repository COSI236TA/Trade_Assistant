class Rule < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  belongs_to :property

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
    property_d_name = property.d_name
    if property_d_name.include?("percent")
      "Let me know if #{portfolio}'s #{property_d_name} is #{rel} than #{target}%"
    else
      "Let me know if #{portfolio}'s #{property_d_name} is #{rel} than #{target}"
    end
  end
end
