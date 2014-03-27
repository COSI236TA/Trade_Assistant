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
    @user = User.find(session[:user_id])
    @rule = @user.rules.build
    respond_with @rule
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @user = User.find(session[:user_id])
    clean_params = rule_params
    clean_params[:property] = PROPERTY_MAP[clean_params[:property]]
    puts clean_params
    @rule = @user.rules.build(clean_params)

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
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
    params.require(:rule).permit(:ticker, :property, :rel, :target)
  end

  def indicator

  end

end
