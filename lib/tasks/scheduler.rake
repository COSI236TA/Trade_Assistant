desc "This task is called by the Heroku scheduler add-on"
task :rule_status_update => :environment do
  puts "Updating rule status ..." 
  RuleEngine::RuleEngine.start
  puts "done."
end
