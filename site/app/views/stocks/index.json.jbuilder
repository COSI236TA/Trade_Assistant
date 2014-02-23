json.array!(@stocks) do |stock|
  json.extract! stock, :id, :symbol, :name
  json.url stock_url(stock, format: :json)
end
