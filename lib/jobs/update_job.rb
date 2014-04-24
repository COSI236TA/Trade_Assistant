class Jobs::UpdateJob 
  include SuckerPunch::Job

  def perform(data)
    puts "#{ Time.now }: Rule Engine starts updating stocks data and rule status" 
    RuleEngine::RuleEngine.start
    puts "#{ Time.now }: Rule Engine finishes." 
  end
  def later(sec, data)
    after(sec) { 
      perform(data) 
      later(sec, data) 
    }
  end
end
