# encoding: utf-8
class TrackMailer < ActionMailer::Base

  default from: "adword@summers.com.tw"
  
  def send_notify( track )
  	@ticket = track.ticket
  	@topic = @ticket.topic
  	
  	attachments.inline['avator.jpg'] = File.read( 'public/images/avator.jpg' )
  	  	
  	mail( to: @topic.get_user_emails, subject: "[夏天回報系統] 收到了追蹤中主題的回報！" ) do | format |
  		format.html { render 'topic' }
  	end
  end
  
  def send_cc( track )
  
  	@ticket = track.ticket
  	@topic = @ticket.topic
  	
  	attachments.inline['avator.jpg'] = File.read( 'public/images/avator.jpg' )
  	
  	# send mail to cc users
  	user_ids = JSON.parse(@ticket.cc)
  	
  	user_mails = @topic.get_user_emails
  	
  	user_ids.each do | user_id |
  		@user = User.find( user_id )
  		user_mails.push( @user.email )  		
  	end  	
  	
  	mail( to: user_mails, subject: "[夏天回報系統] 收到了追蹤中主題的回報！" ) do | format |
  		format.html { render 'cc' }
  	end
  end
  
#  handle_asynchronously :send_notify
end
