class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_authorization
  before_filter :log
  def check_authorization
    if (!user_signed_in?)
    	redirect_to new_user_session_path

    else
    	get_user_subscribe
    end
  end
  def get_user_subscribe
  	
    @subscribes = Subscribe.find(:all,
            :conditions => {:user_id => current_user.id},
            :joins => "LEFT JOIN topics ON topics.id = subscribes.topic_id" ,
            :select => "subscribes.*, topics.name, topics.count")
  	
  end
  def log
    #log
    
  end
end
