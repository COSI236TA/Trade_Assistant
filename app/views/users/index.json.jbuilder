json.array!(@users) do |user|
  json.extract! user, :id, :email, :account_name
  json.url user_url(user, format: :json)
end
