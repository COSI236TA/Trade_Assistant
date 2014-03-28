#Initialize the RuleHistory when starts the server
if ActiveRecord::Base.connection.tables.include?('rule_histories')
  RuleEngine::RuleEngine.start
end
