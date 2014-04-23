class AjaxController < ApplicationController
  include RulesHelper
  #returns data as json request for each stock ticker
  def get_stock_history


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

  #auto completion for ticker input
  def ticker_auto_complete
    #ignore cases
    s = params[:q].downcase
    result = []
    stock_list = STOCK_LIST
    id = 0;
    stock_list.each do |ticker, name|
      #ignore cases
      dticker = ticker.downcase
      dname = name.downcase
      if dticker.include?(s) or dname.include?(s)
        result << { "id" => id, "ticker" => ticker, "name" => name}
      end
      id += 1
      break if result.size >= 10
    end
    respond_to do |format|
      format.json { render :json => result}
    end
  end

    #resopond to AJAX select or create portfolio
  def select_portfolio
    @user = User.find(session[:user_id])
    @rule = @user.rules.build
    @portfolios = @user.portfolios.map { |p| [p.name, p.id, p.description] }
    @properties = get_properties
    @rel = [["More than", "more"], ["Less than", "less"]]

    respond_to do |format|
      format.js {}
    end
  end

  def create_portfolio
    @user = User.find(session[:user_id])
    @rule = @user.rules.build
    @portfolio = @user.portfolios.build
    @properties = get_properties
    @rel = [["More than", "more"], ["Less than", "less"]]

    respond_to do |format|
      format.js {}
    end
  end

  def portfolio_info
    pid = params[:pid].to_i

    portfolio = Portfolio.find(pid)

    stocks = portfolio.stocks.map do |s| 
      { ticker: s.ticker, name: STOCK_LIST[s.ticker], stock_data: DataPool::DataPool.query(s.ticker) }
    end
    puts stocks

    respond_to do |format|
      format.json { render :json => stocks }
    end
  end
  
  def stock_info
    ticker = params[:ticker]
    result = DataPool::DataPool.query ticker

    respond_to do |format|
      format.json { render :json => result  }
    end
  end

end