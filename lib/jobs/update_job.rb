class Jobs::UpdateJob 
  include SuckerPunch::Job

  def perform(data)
    puts "#{ Time.now }: Rule Engine starts updating stocks data and rule status" 
    RuleEngine::RuleEngine.start
    Jobs::UpdateJob.new.async.later(300, "Update starts")

    puts "#{ Time.now }: Rule Engine finishes." 
  end
  def later(sec, data)
    after(sec) { 
      perform(data) 
    }
  end
end
