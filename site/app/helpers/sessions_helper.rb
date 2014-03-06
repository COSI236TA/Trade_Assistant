module SessionsHelper

  def get_user_name
      #User.find_by(name: params[:name])
      User.find(session[:user_id]).name
  end

  def user_logged_in?
      return (session[:user_id] != nil)
  end
  
  def destroy
      session[:user_id] = nil
  end

end
