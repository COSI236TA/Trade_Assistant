module PortfoliosHelper
  def get_portfolios
    @user.portfolios.map { |p| [p.name, p.id, p.description] }
  end
end