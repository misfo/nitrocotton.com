# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  helper_method :current_user_id

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'aeb5c6068c4317d66f4abcffcc2045d5'

  protected
    def current_user
      if @current_user.nil?
        if session[:user_id]
          @current_user = User.find(session[:user_id])
        else
          @current_user = User.find_or_create_by_ip_address(request.remote_ip)
          session[:user_id] = @current_user.id
        end
      end
      @current_user
    end

    # potentially saves a database call over current_user.id
    def current_user_id
      session[:user_id] || current_user.id
    end
end
