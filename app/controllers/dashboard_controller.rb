class DashboardController < ApplicationController
  include SessionsHelper

  def new
    # @my_rules = 
  end

  def create
  end

  def index
    x = request.env['omniauth.auth']
    p "*************"
    p x
    p "*************"
    if user_logged_in?
      #commented out due to problems accessing dashboard
      @user = User.find(session[:user_id])
      @user_name = @user.name
      @my_rules = @user.rules.all
    else
      redirect_to login_path
    end
  end
end
