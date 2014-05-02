class AjaxController < ApplicationController
  include RulesHelper
  include PortfoliosHelper

  def get_twitter_rating

     stock_name = params[:stock]

     #use of twitter
     client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "07MR13DREG5LnUuiFqgXJTTDl"
      config.consumer_secret     = "p3tR0GXc9o0AKWEwOPHWmV5wedlaIv6iNx7UBcg4ZzYP0KcmaQ"
      config.access_token        = "2244833450-j7q6dhN5H3I3YNs5fM4VTlja1r31FEXCO3KpxHg"
      config.access_token_secret = "V0GMof1aKZPKAUQzIErTfQtLyLpBATvf5h1Ah158CGlB9"
     end

     p "HI"
     #save for testing
      #@ratings_hash = Hash.new
      Sentimental.load_defaults
     #Sentimental.threshold = 0.1
      analyzer = Sentimental.new #default score is 0
      #p (analyzer.get_score 'I kind of like ruby')
      #p (analyzer.get_score 'I kinda like ruby')
      #p (analyzer.get_score 'I like ruby')
  
      p "HI22"
      #@ratings_hash = Hash.new
      #@portfolio_stocks.each do |stock|

         count_good_scores = 0
         total_tweets = 0

         client.search(stock_name, :count => 100).each do |tweet|
           #count = count + (analyzer.get_score tweet.text)
           total_tweets = total_tweets + 1
           if((analyzer.get_score tweet.text) > 0)

              count_good_scores = count_good_scores + 1

           end
           #p analyzer.get_score tweet.text
         end
         p count_good_scores
         p total_tweets
         percentage_good = (((count_good_scores * 1.0)/total_tweets) * 100).round(2)
         p percentage_good
         rating = percentage_good.to_s + "% Good"

       #p count

         #if(count > 0)
          # rating = 'Good'
        
         #elsif(count < 0)
          # rating = 'Bad'
      
         #else(count = 0)
         #  rating = 'Neutral'
        
         #end

         p "HEY"
        p rating

        render :text => rating

       #end

  end


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
    @portfolios = get_portfolios
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

  def get_property_description
    property = Property.find_by(id: params[:property_id])
    respond_to do |format|
      if property != nil
        format.json { render json: property} 
      end
    end
  end

end