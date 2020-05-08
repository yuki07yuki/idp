module SessionsHelper

  def login user
    session[:user_id] = user.id
  end

  def logout
    session.delete :user_id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:user_id]
      Resident.find_by(id: session[:user_id])
    end
  end


end
