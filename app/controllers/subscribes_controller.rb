class SubscribesController < ApplicationController
  def topicShow
  	@tickets = Ticket.find(:all,
  		:conditions => {:topic_id => params[:id]},
  		:joins => "LEFT JOIN 'topics' ON topics.id = tickets.topic_id",
  		:select => "tickets.*, topics.name, topics.color",
  		:order => "created_at ASC")
  end

  def destroy
    #redirect_to request.referer
    @subscribe = Subscribe.find(params[:id])
    respond_to do |format|
      format.json { render json: @subscribe}
      format.js
    end
  end

  def create
  	exit
  	@subscribe = Subscribe.new
  	@subscribe.user_id = current_user.username

  	respond_to do |format|
      format.json { render json: @subscribe}
      format.js
    end
  	
  end

end