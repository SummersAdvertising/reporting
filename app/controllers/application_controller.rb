# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_authorization
  before_filter :log

  def check_authorization
    if (!user_signed_in?)
    	redirect_to new_user_session_path

    else
    	get_user_subscribe
      get_recent_tickets
      get_new_track_tickets
    end
  end

  def get_user_subscribe

    @subscribes = Subscribe.find(:all,
            :conditions => {:user_id => current_user.id},
            :joins => "LEFT JOIN topics ON topics.id = subscribes.topic_id" ,
            :select => "subscribes.*, topics.name, topics.count")
  	
  end

  def get_recent_tickets
    
    @recent = Ticket.find(:all,
            :conditions => ["tickets.created_at > ? ", Time.now - 3.days ],
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "(case tickets.status
        when 'open' then 0
        else 1
        end),
        (case priority
        when 'high' then 0
        when 'medium' then 1
        when 'low' then 2
        else 3
        end), deadline ASC, created_at ASC")
    
  end

  def get_new_track_tickets
    
    @newtrack = Ticket.find(:all,
      :conditions => ["tracks.status = ? ", "track" ],
      :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter LEFT JOIN tracks ON tracks.ticket_id = tickets.id" ,
      :select => "tickets.*, topics.name, topics.color, users.username, tracks.created_at",
      :order => "(case tickets.status
        when 'open' then 0
        else 1
        end),
        tracks.created_at ASC,
        (case priority
        when 'high' then 0
        when 'medium' then 1
        when 'low' then 2
        else 3
        end), deadline ASC",
      :group => "tickets.id",
      :limit => 20)
    
  end

  def is_admin
    if (user_signed_in? && current_user.role != "admin" )
      flash[:IDnotice] = "你的權限無法進行此操作。"
      redirect_to(:back)
    end   
  end

  def log
    #log
    
  end

end
