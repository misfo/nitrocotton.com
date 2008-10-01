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
    def user_session
      @user_session ||= UserSession.new(session, request)
    end
    
    def current_user
      user_session.user
    end

    # potentially saves a database call over current_user.id
    def current_user_id
      session[:user_id] || current_user.id
    end
end
