class DashboardController < ApplicationController
  include SessionsHelper

  def new
    @my_rules = 1
  end

  def create
  end

  def index
    if user_logged_in?
      @my_rules = User.find(session[:user_id]).rules.all
    else
      redirect_to login_path
    end
  end
end
