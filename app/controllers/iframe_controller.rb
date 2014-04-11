class IframeController < ApplicationController
require 'yahoo_stock'


  #returns data as json request for each stock ticker
  def get_stock_json


    #the data for all stocks
    all_stock_dates_closing = Array.new

    # check each stock
    params[:tickers].each do |ticker|
      
      history = YahooStock::History.new(:stock_symbol => ticker, :start_date => Date.today-366, :end_date => Date.today-1).results(:to_array).output
      stock_dates_with_closing = Array.new

      history.each do |date|
        #add each date and its closing stock value to the array
        stock_dates_with_closing << [Date.strptime(date[0], '%Y-%m-%d').to_time.to_i * 1000,date[4].to_f]

      end

      #array needs to be sorted for highstocks javascript
      stock_dates_with_closing = stock_dates_with_closing.sort_by{|x,y|x}
      all_stock_dates_closing << stock_dates_with_closing

    end

    render :json =>  all_stock_dates_closing

  end

  #lightbox portfolio page
  def get_portfolio_html
     #gets portfolio id
     portfolio = Portfolio.find(params[:portfolio_id])

     #portfolio information
     @portfolio_name = portfolio.name.gsub(/\b\w/){ $&.upcase } #Makes each first char upper case
     @portfolio_description = portfolio.description
     @portfolio_stocks = portfolio.stocks
     @portfolio_rules = portfolio.rules

     #store each ticker into an array
     @stock_ticker_array = Array.new
     @portfolio_stocks.each do |stock|

     @stock_ticker_array << stock.ticker

     end


     #use of twitter
     client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "07MR13DREG5LnUuiFqgXJTTDl"
      config.consumer_secret     = "p3tR0GXc9o0AKWEwOPHWmV5wedlaIv6iNx7UBcg4ZzYP0KcmaQ"
      config.access_token        = "2244833450-j7q6dhN5H3I3YNs5fM4VTlja1r31FEXCO3KpxHg"
      config.access_token_secret = "V0GMof1aKZPKAUQzIErTfQtLyLpBATvf5h1Ah158CGlB9"
     end

      p "********************************"

      p client.search("GOOGLE", :count => 100).first.text
      p client.search("GOOGLE", :count => 100).first.id
  
     render :layout=> "iframe_portfolio"

  end

  #lightbox rule page
  def get_rule_html   

     current_rule = Rule.find(params[:rule_id])

     #rule information
     @rule_name = current_rule.name
     @rule_description = current_rule.description
     @rule_last_triggered = current_rule.last_triggered

     #portfolio information
     @portfolio_name = current_rule.portfolio.name

     render :layout=> "iframe_rule"

  end




end
