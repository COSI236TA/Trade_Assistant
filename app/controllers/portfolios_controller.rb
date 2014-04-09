class PortfoliosController< ApplicationController
require 'yahoo_stock'

  def get_stock_json


    history = YahooStock::History.new(:stock_symbol => params[:ticker], :start_date => Date.today-366, :end_date => Date.today-1).results(:to_array).output
    stock_dates_with_closing = Array.new

    history.each do |date|
      
      stock_dates_with_closing << [Date.strptime(date[0], '%Y-%m-%d').to_time.to_i * 1000,date[4].to_f]

    end

    stock_dates_with_closing = stock_dates_with_closing.sort_by{|x,y|x}
    


    render :json => stock_dates_with_closing.to_json

  end


  def get_portfolio_html

     portfolio = Portfolio.find(params[:portfolio_id])

     @portfolio_name = portfolio.name.gsub(/\b\w/){ $&.upcase } #Makes each first char upper case
     @portfolio_description = portfolio.description
     @portfolio_stocks = portfolio.stocks

     render :layout=> "portfolios"

  end

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = Portfolio.all
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
