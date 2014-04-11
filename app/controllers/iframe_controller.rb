class IframeController < ApplicationController
require 'yahoo_stock'



  def get_stock_json


    all_stock_dates_closing = Array.new

    params[:tickers].each do |ticker|
      
      history = YahooStock::History.new(:stock_symbol => ticker, :start_date => Date.today-366, :end_date => Date.today-1).results(:to_array).output
      stock_dates_with_closing = Array.new

      history.each do |date|
        
        stock_dates_with_closing << [Date.strptime(date[0], '%Y-%m-%d').to_time.to_i * 1000,date[4].to_f]

      end

      stock_dates_with_closing = stock_dates_with_closing.sort_by{|x,y|x}
      all_stock_dates_closing << stock_dates_with_closing

    end

    render :json =>  all_stock_dates_closing

  end


  def get_portfolio_html

     portfolio = Portfolio.find(params[:portfolio_id])

     @portfolio_name = portfolio.name.gsub(/\b\w/){ $&.upcase } #Makes each first char upper case
     @portfolio_description = portfolio.description
     @portfolio_stocks = portfolio.stocks
     @portfolio_rules = portfolio.rules

     @stock_ticker_array = Array.new
     @portfolio_stocks.each do |stock|

     @stock_ticker_array << stock.ticker

     end
 
     render :layout=> "iframe_portfolio"

  end


  def get_rule_html   

     current_rule = Rule.find(params[:rule_id])
     @rule_name = current_rule.name
     @rule_description = current_rule.description
     @rule_last_triggered = current_rule.last_triggered
     @portfolio_name = current_rule.portfolio.name

     render :layout=> "iframe_rule"

  end




end
