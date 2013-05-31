class SubscribesController < ApplicationController
  def topicShow
  	@tickets = Ticket.find(:all,
  		:conditions => {:topic_id => params[:id]},
  		:joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter",
  		:select => "tickets.*, topics.name, topics.color, users.username",
  		:order => "tickets.created_at ASC")
  end

  def destroy
    @subscribe = Subscribe.find(params[:id])
    @subscribe.destroy

    respond_to do |format|
      format.json { render json: @subscribe}
      format.js
    end
  end

  def create
    @topic = JSON.parse(params[:topic])

  	@subscribe = current_user.subscribes.new
    @subscribe.topic_id = @topic["id"]
    
    if(@subscribe.save)
      @subscribe["name"] = @topic["value"]
      @subscribe["count"] = 0

      respond_to do |format|
        format.json { render json: @subscribe}
        format.js
      end
    end
  end

end