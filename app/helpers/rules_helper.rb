module RulesHelper
  def get_properties
    return Property.where("id <= 21").map do |p|
      d_name = p.d_name.split.map(&:capitalize).join(' ')
      [d_name, p.id] 
   end
  end

  def prepare_parameters
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
    real_property = Property.find(property)
    build_params = { 
      :portfolio => portfolio,
      :property => real_property,
      :rel => rel,
      :target => target, 
      :name => "#{portfolio.name} #{portfolio.rules.size+1}",
      :description => Rule.get_description(portfolio, real_property, rel, target)
    }
    return build_params
  end
end
