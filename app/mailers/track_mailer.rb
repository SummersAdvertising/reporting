# encoding: utf-8
class TrackMailer < ActionMailer::Base

  default from: "adword@summers.com.tw"
  
  def send_notify( ticket )
  	@ticket = ticket
  	@topic = ticket.topic
  	
  	attachments.inline['avator.jpg'] = File.read( 'public/images/avator.jpg' )
  	
  	mail( to: @topic.get_user_emails, subject: "[夏天回報系統] 收到了追蹤中主題的回報！" ) do | format |
  		format.html { render 'notify' }
  	end
  	
  end
  
#  handle_asynchronously :send_notify
end
