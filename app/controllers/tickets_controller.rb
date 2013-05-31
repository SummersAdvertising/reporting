# coding: utf-8
class TicketsController < ApplicationController
  def index
    if(params[:order] == "createDESC")
      @tickets = Ticket.find(:all,
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "created_at ASC")
    else
      @tickets = Ticket.find(:all,
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "(case priority
        when 'high' then 0
        when 'medium' then 1
        when 'low' then 2
        else 3
        end), deadline ASC, created_at ASC")
    end

    @ticket = Ticket.new
    
  end

  def show
  	@ticket = Ticket.find(:first,
            :conditions => ["tickets.id = ?",params[:id] ],
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "created_at ASC")

    @track = Track.new
    @tracks = Track.find(:all,
            :conditions => ["tracks.ticket_id = ?",params[:id] ],
            :joins => "LEFT JOIN users ON users.id = tracks.actor" ,
            :select => "tracks.status, tracks.comment, tracks.created_at, users.username",
            :order => "tracks.created_at ASC")

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
    @ticket.reporter = current_user.id
    @ticket.cc = params[:cc].to_json
    @ticket.status = "open"

    respond_to do |format|
      if @ticket.save
        params[:tag].each do |tag|
          @tickettag = Tickettag.new
          @tickettag.ticket_id = @ticket.id
          @tickettag.tag_id = tag

          @tickettag.save
        end

        format.html { redirect_to root_path, notice: 'ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { redirect_to root_path }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    @ticket = Ticket.find(params[:id])
    @ccDel = @ticket.cc
    @ccNew = (params[:cc].to_json)

    return render :text => @ccNew
    exit
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

  def compare
  end

  def destroy
    
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def query
    @tickets = Ticket.find(:all,
            :conditions => ["description like ?","%"+ params[:query] + "%"],
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "created_at ASC")
  end

  def reopen
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.status = "open"
    @ticket.save

    @track = @ticket.tracks.new
    @track.status = "log"
    @track.actor = current_user.id
    @track.comment = "重新開啟該回報。"

    @track.save

    respond_to do |format|
      format.html { redirect_to ticket_path(@ticket) }
      format.json { head :no_content }
    end
    
  end

  def close
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.status = "close"
    @ticket.save

    @track = @ticket.tracks.new
    @track.status = "log"
    @track.actor = current_user.id
    @track.comment = "關閉該回報，原因："+params[:track]["comment"]+"。"

    @track.save

    respond_to do |format|
      format.html { redirect_to ticket_path(@ticket) }
      format.json { head :no_content }
    end
    
  end
end
