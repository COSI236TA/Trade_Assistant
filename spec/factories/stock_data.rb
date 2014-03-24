# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_datum, :class => 'StockData' do
    symbol "MyString"
    price 1.5
    marketcap 1.5
    volume ""
    last_update_time "2014-03-24 10:07:30"
  end
end
