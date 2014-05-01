class RuleMailer < ActionMailer::Base
  default from: "trade-assistant@trade-assistant.com"

  def rule_notify user, rule, stocks
    @user = user
    @rule = rule
    @stocks = stocks
    mail :subject => "Rule #{rule.name} is triggered!",
         :to      => user.email
  end
end
