class UserSession
  def initialize(session, request)
    @session, @request = session, request
  end
  
  def user
    @user ||= if @session[:user_id]
      User.find(@session[:user_id])
    else
      user = User.find_or_create_by_ip_address(@request.remote_ip)
      @session[:user_id] = user.id
      user
    end
  end

  # could save a database call over #user.id
  def user_id
    @session[:user_id] || user.id
  end
end
