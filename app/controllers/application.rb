# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #include ExceptionNotifiable

  helper :all # include all helpers, all the time

  helper_method :user_session

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'aeb5c6068c4317d66f4abcffcc2045d5'

  protected
    def user_session
      @user_session ||= UserSession.new(session, request)
    end
end
