module SessionsHelper

  def go_to_dashboard
    format.html { redirect_to dashboard_path }
  end


  def get_email
    #User.find_by(name: params[:name])
    if !session[:user_id].nil?
      user = User.find(session[:user_id])
      if user != nil
        user.email
      else
        "Error"
      end
    else
      "error"
    end
  end

  def user_logged_in?
    return (session[:user_id] != nil) && User.find(session[:user_id]) != nil
  end

  def destroy
    session[:user_id] = nil
  end

end
