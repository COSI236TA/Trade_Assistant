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

    #Get portfolio params
    portfolio_params = params[:portfolio]

    if portfolio_params[:action] == "select"
      #need to create the portfolio
      puts "1"
    elsif portfolio_params[:action] == "create"
      #get the tickers from params
      tickers = portfolio_params[:ticker].values.map { |i| i[:ticker] }
      puts tickers

    end



    #

    #Build params for create rule
    # build_params = { 
    #   :portfolio => Portfolio.find(clean_params[:portfolio]),
    #   :property => Property.find(clean_params[:property]),
    #   :rel => clean_params[:rel],
    #   :target => clean_params[:target]
    # }

    # @rule = @user.rules.create(build_params)
    # if !@rule.valid?
    #   format.html { redirect_to create_rule_path, notice: 'Rules are not successfully created .' }
    # end

    # RuleEngine::RuleEngine.start
    # redirect_to dashboard_path

    respond_to do |format|
      format.json { render :json => {} }
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
      format.html { redirect_to rules_url }
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
