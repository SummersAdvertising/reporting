class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_authorization
  def check_authorization
    if (!user_signed_in?)
    	redirect_to new_user_session_path
    end
  end
end
