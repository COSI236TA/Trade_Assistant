class DashboardController < ApplicationController
  include SessionsHelper

  def new
    # @my_rules = 
  end

  def create
  end

  def index
    if user_logged_in?
      #commented out due to problems accessing dashboard
      #@my_rules = User.find(session[:user_id]).rules.all
    else
      redirect_to login_path
    end
  end
end
