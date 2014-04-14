if ActiveRecord::Base.connection.tables.include?('rule_histories')
  Jobs::UpdateJob.new.async.perform("Update starts")
  Jobs::UpdateJob.new.async.later(60, "Update starts")
end