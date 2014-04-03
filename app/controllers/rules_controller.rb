require 'json'

class RulesController < ApplicationController
  PROPERTY_MAP = {'1' => 'price', '2' => 'volume', '3' => 'marketcap', '4' => 'div', '5' => 'yld', '6' => 'p/e'}
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all
  end

  def get_rule_html   
     @rule_name = Rule.find(params[:id]).name
     @rule_description = Rule.find(params[:id]).description
     @rule_last_triggered = Rule.find(params[:id]).last_triggered
     
     render :layout=>false

  end



  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    #Find the user
    @user = User.find(session[:user_id])

    #Get clean params
    rule_clean_params = rule_params

    #Get property
    property = rule_clean_params[:property].to_s

    #Get rel
    rel = rule_clean_params[:rel]

    #Get target
    target = rule_clean_params[:target]

    #Get portfolio params
    portfolio_params = params[:portfolio]
    portfolio = nil


    #deal with create or select portfolio
    if portfolio_params[:action] == "select"
      #need to create the portfolio
      portfolio_id = portfolio_params[:id].to_i
      portfolio = @user.portfolios.find(portfolio_id)
    elsif portfolio_params[:action] == "create"
      #get the tickers from params
      tickers = portfolio_params[:ticker].values.map { |i| i[:ticker] }
      name = portfolio_params[:name]
      description = portfolio_params[:description]

      portfolio = @user.portfolios.create(name: name, description: description)

      tickers.each do |ticker|
        DataPool::DataUpdater.update ticker
        stock = Stock.find_by(ticker: ticker)
        portfolio.stocks << stock

        puts portfolio.stocks
      end
    end

    #create rule

    #Build params for create rule
    build_params = { 
      :portfolio => portfolio,
      :property => Property.find(property),
      :rel => rel,
      :target => target 
    }

    @rule = @user.rules.create(build_params)
    response = true
    if !@rule.valid?
      response = false
    end

    #Start the RuleEngine
    RuleEngine::RuleEngine.start

    respond_to do |format|
      format.json { render :json => {response: response } }
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def auto_complete
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
    @properties = Property.all.map { |p| [p.d_name, p.id] }
    @rel = [["More than", "more"], ["Less than", "less"]]

    respond_to do |format|
      format.js {}
    end
  end

  def create_portfolio
    @user = User.find(session[:user_id])
    @rule = @user.rules.build
    @portfolio = @user.portfolios.build
    @properties = Property.all.map { |p| [p.d_name, p.id] }
    @rel = [["More than", "more"], ["Less than", "less"]]

    respond_to do |format|
      format.js {}
    end
  end


  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rule
    @rule = Rule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rule_params
    #Map the number to the real property name
    params.require(:rule).permit(:property, :rel, :target)
  end

end
