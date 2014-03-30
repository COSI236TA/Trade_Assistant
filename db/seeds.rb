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
user = User.create(email: "a@b.c", password: "12345", password_confirmation: "12345")
puts "Seed done"
user.rules.create(ticker: "GOOG", property: "price", rel: "up", target: 1000)
user.rules.create(ticker: "AAPL", property: "price", rel: "up", target: 1000)
user.rules.create(ticker: "TSLA", property: "price", rel: "up", target: 1000)
