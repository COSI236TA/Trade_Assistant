module UsersHelper

	def get_notification

	user = User.find_by(id: session[:user_id])
      if user != nil
        user.notification
      else
        "Error"
      end

	end


end
