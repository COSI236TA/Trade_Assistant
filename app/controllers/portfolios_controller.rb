class PortfoliosController< ApplicationController

  

  # GET /portfolios
  # GET /portfolios.json
  def index
    @user = User.find(session[:user_id])
    @portfolios = @user.portfolios
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
  end

  # GET /portfolios/new
  def new
    @user = User.find(session[:user_id])
    @portfolio = @user.portfolios.build
    respond_with @portfolio
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @user = User.find(session[:user_id])
    clean_params = portfolio_params

    #Clean paramters 
    name = clean_params[:name]
    description = clean_params[:description]
    tickers = clean_params[:tickers].split(",")

    #Build portfolio, without stocks
    @portfolio = Portfolio(name: name, description: description)

    #Find the stocks in db, add to portfolio
    tickers.each do |ticker|
      DataPool::DataUpdater ticker
      stock = Stock.find_by(ticker: ticker)
      @portfolio.stocks << stock
    end
  end



  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to @portfolio, notice: 'portfolio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end



  #get portfolio page and display it in iframe
  #lightbox portfolio page
  def get_portfolio
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


     client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "07MR13DREG5LnUuiFqgXJTTDl"
      config.consumer_secret     = "p3tR0GXc9o0AKWEwOPHWmV5wedlaIv6iNx7UBcg4ZzYP0KcmaQ"
      config.access_token        = "2244833450-j7q6dhN5H3I3YNs5fM4VTlja1r31FEXCO3KpxHg"
      config.access_token_secret = "V0GMof1aKZPKAUQzIErTfQtLyLpBATvf5h1Ah158CGlB9"
     end

      p "********************************"

      Sentimental.load_defaults
    #Sentimental.threshold = 0.1
analyzer = Sentimental.new #default score is 0
   p (analyzer.get_score 'I kind of like ruby')
   p (analyzer.get_score 'I kinda like ruby')
   p (analyzer.get_score 'I like ruby')
  

   @ratings_hash = Hash.new
   @portfolio_stocks.each do |stock|

     count = 0
      client.search(stock.name, :count => 100).each do |tweet|
        count = count + (analyzer.get_score tweet.text)
      end

      #p count

      if(count > 0)
        rating = 'Good'
      
      elsif(count < 0)
        rating = 'Bad'
    
      else(count = 0)
        rating = 'Neutral'
      
      end

      p stock.name
      p count

      @ratings_hash[stock.ticker] = rating

    end
      #p client.search("GOOGLE", :count => 100).first.id
  



    if params[:type] == "iframe" 
      render :layout => "iframe_portfolio"
    elsif params[:type] == "page"
      render :layout => "application"
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio = portfolio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def portfolio_params
    #Map the number to the real property name
    params.require(:portfolio).permit(:tickers, :name, :description)
  end

end
