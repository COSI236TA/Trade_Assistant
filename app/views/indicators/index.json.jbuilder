json.array!(@indicators) do |indicator|
  json.extract! indicator, :id, :name, :query_parameter
  json.url indicator_url(indicator, format: :json)
end
