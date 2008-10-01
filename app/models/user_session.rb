class UserSession
  def initialize(session, request)
    @session, @request = session, request
    @session[:viewed_shirt_ids] ||= []
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
  
  def impress_me?
    viewed_shirt_ids.size < 16
  end
  
  def viewed_shirts(shirts)
    @session[:viewed_shirt_ids] = @session[:viewed_shirt_ids] | shirts.collect(&:id)
  end
  
  def viewed_shirt_ids
    @session[:viewed_shirt_ids]
  end
end