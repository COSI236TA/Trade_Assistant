module SessionsHelper

  def user_logged_in?
      return (session[:@user_id] != nil)
  end
  
  def destroy
      session[:@user_id] = nil
  end

end
