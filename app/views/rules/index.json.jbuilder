json.array!(@rules) do |rule|
  json.extract! rule, :id, :stock_id, :indicator_id, :up_or_down, :margin
  json.url rule_url(rule, format: :json)
end
