class Jobs::EmailJob
  include SuckerPunch::Job

  ##Send email asycronously 
  def perform(mail)
    RuleMailer.rule_notify(mail[:user], mail[:rule], mail[:stocks]).deliver
  end
end
