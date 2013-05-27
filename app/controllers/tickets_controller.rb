class TicketsController < ApplicationController
  def test
  	@tickets = Ticket.order("(case priority 
     when 'high' then 0 
     when 'medium' then 1
     when 'low' then 2
     else 3
     end), deadline ASC, created_at ASC").all

  	@ticket = Ticket.new

    #topics for autocomplete
    @topics = Array.new
    Topic.all.each do |topic|
      @topics.push({:id => topic.id, :label => topic.name})
    end

    @topics = @topics.to_json

  	respond_to do |format|
  		format.html # index.html.erb
  	end
  end

  def index
    if(params[:order] == "createDESC")
      @tickets = Ticket.find(:all,
            :joins => "LEFT JOIN 'topics' ON topics.id = tickets.topic_id" ,
            :select => "tickets.*, topics.name, topics.color",
            :order => "created_at ASC")
    else
      @tickets = Ticket.find(:all,
            :joins => "LEFT JOIN 'topics' ON topics.id = tickets.topic_id" ,
            :select => "tickets.*, topics.name, topics.color",
            :order => "(case priority
        when 'high' then 0
        when 'medium' then 1
        when 'low' then 2
        else 3
        end), deadline ASC, created_at ASC")
    end

    @topics = Topic.all
    @subscribes = Subscribe.find(:all,
            :conditions => {:user_id => current_user.id},
            :joins => "LEFT JOIN 'topics' ON topics.id = subscribes.topic_id" ,
            :select => "subscribes.*, topics.name, topics.count")
    
  end

  def show
  	@ticket = Ticket.find(params[:id])

  	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to root_path, notice: 'ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def getUsers
    @users = Array.new

    User.all.each do |user|
      @user = {"id" => user.id, "label" => (user.username + " " + user.email), "value" => user.username}

      @users.push(@user)
    end

    respond_to do |format|
      format.json { render json: @users}
    end
    
  end

  def topic
    @tickets = Ticket.find(:all,
            :conditions => {:topic_id => params[:id]},
            :joins => "LEFT JOIN 'topics' ON topics.id = tickets.topic_id" ,
            :select => "tickets.*, topics.name, topics.color",
            :order => "created_at ASC")

    @topics = Topic.all
    @subscribes = Subscribe.find(:all,
            :conditions => {:user_id => current_user.id},
            :joins => "LEFT JOIN 'topics' ON topics.id = subscribes.topic_id" ,
            :select => "subscribes.*, topics.name, topics.count")
    
  end
  def topicDel
    redirect_to request.referer
    
  end
end
