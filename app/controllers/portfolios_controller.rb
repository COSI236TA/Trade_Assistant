class PortfoliosController< ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]


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
    #gets portfolio
    @portfolio = Portfolio.find_by(id: params[:portfolio_id])

    #portfolio information
    if @portfolio != nil
      @portfolio_capa_name = first_char_cap(@portfolio.name) #Makes each first char upper case

      #store each ticker into an array
      @stock_ticker_array = Array.new
      @portfolio.stocks.each do |stock|
        @stock_ticker_array << stock.ticker
      end

    end
    p "********************************"

    #p client.search("GOOGLE", :count => 100).first.id




    if params[:type] == "iframe"
      p "*******TRUEEEEEEEEEEEEE"
      render :layout => "iframe_portfolio"
    elsif params[:type] == "page"
      render :layout => "application"
    end
  end

  def first_char_cap(text)
    text.gsub(/\b\w/){ $&.upcase }
  end




  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    render :layout => "iframe_portfolio"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def portfolio_params
    #Map the number to the real property name
    params.require(:portfolio).permit(:tickers, :name, :description)
  end

end
