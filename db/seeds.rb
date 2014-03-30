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
user = User.create(email: "a@b.c", password: "12345", password_confirmation: "12345")

#Create portfolios
portfolio = user.portfolios.create(name: "high tech", description: "several high tect stocks")


tickers.each do |ticker|
  DataPool::DataUpdater.update ticker
  portfolio.stocks << Stock.find_by(ticker: ticker)
end

user.rules.create(portfolio: portfolio, property: Property.find(7), rel: "more", target: "1")
user.rules.create(portfolio: portfolio, property: Property.find(7), rel: "less", target: "1")
puts "Seed done"
