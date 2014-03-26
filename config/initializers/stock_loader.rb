#load stock symbols and name from txt file to memory


def load_stocks
  require 'csv'
  path = "completelist"
  file = "#{Rails.root}/app/txtfiles/#{path}"

  stock_list = []
  CSV.foreach(file, :col_sep => "|") do |row|
    entry = { row[0] => row[1] }
    stock_list << entry
  end
  return stock_list
end

STOCK_LIST = load_stocks
