# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding"

User.destroy_all
Rule.destroy_all
Portfolio.destroy_all
tickers = ["GOOG", "TSLA", "AAPL"]
user1 = User.create(email: "a@b.c", name: "Alice", password: "12345", password_confirmation: "12345", notification: "email")
user2 = User.create(email: "tradeassistanttest@gmail.com", name: "Millionare", password: "12345", password_confirmation: "12345", notification: "email")


#Create portfolios
portfolio1 = user1.portfolios.create(name: "high tech", description: "several high tect stocks")
portfolio2 = user2.portfolios.create(name: "high tech", description: "several high tect stocks")


tickers.each do |ticker|
  DataPool::DataUpdater.update ticker
  portfolio1.stocks << Stock.find_by(ticker: ticker)
  portfolio2.stocks << Stock.find_by(ticker: ticker)
end

user1.rules.create(portfolio: portfolio1, property: Property.find(7), rel: "more", target: "1", name: "high tech 1", activated: "false")
user1.rules.create(portfolio: portfolio1, property: Property.find(7), rel: "less", target: "1", name: "high tech 2", activated: "false")
user2.rules.create(portfolio: portfolio2, property: Property.find(7), rel: "more", target: "1", name: "high tech 1" )
user2.rules.create(portfolio: portfolio2, property: Property.find(7), rel: "less", target: "1", name: "high tech 2" )
puts "Seed done"
