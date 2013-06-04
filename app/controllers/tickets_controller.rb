# coding: utf-8
class TicketsController < ApplicationController
  def index
    if(params[:order] == "createDESC")
      @tickets = Ticket.find(:all,
            :joins => "LEFT JOIN topics ON topics.id = tickets.topic_id LEFT JOIN users ON users.id = tickets.reporter" ,
            :select => "tickets.*, topics.name, topics.color, users.username",
            :order => "(case tickets.status
        when 'open' then 0
        else 1
        end),created_at ASC")
    else
      @tickets = Ticket.find(:all,
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
        params[:tag] && params[:tag].each do |tag|
          @tickettag = Tickettag.new
          @tickettag.ticket_id = @ticket.id
          @tickettag.tag_id = tag

          @tickettag.save
        end

        params[:tagnew] && params[:tagnew].each do |tag|
          @tag = Tag.new
          @tag.name = tag

          if(@tag.save)
            @tickettag = Tickettag.new
            @tickettag.ticket_id = @ticket.id
            @tickettag.tag_id = @tag.id

            @tickettag.save
          end
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

    if(!params[:ticket][:deadline].blank? && !(params[:ticket][:deadline] == (@ticket.deadline ? @ticket.deadline.strftime("%Y-%m-%d") : "")))
      newTrack("log", "將期限調整為："+params[:ticket][:deadline])
    end

    if(!params[:ticket][:period].blank? && !(params[:ticket][:period] == @ticket.period))
      newTrack("log", "修改了備註。")
    end

    if(@ticket.priority != params[:priority])
      case params[:priority]
      when "high"
        @priority = "緊急"
      when "medium"
        @priority = "普通"
      when "low"
        @priority = "暫緩"
      else
        @priority = "普通"
      end

      newTrack("log", "將優先權調整為："+@priority)
    end

    begin
      @ccOld = JSON.parse(@ticket.cc)
    rescue
      @ccOld = Array.new
    end

    @tagOld = Array.new
    @ticket.tags.each do |tag|
      @tagOld.push(tag.id.to_s)
    end

    @tagDelete = @tagOld - (params[:tag]||Array.new)
    @tagCreate = (params[:tag]||Array.new) - @tagOld

    if(@tagDelete.length > 0)
      @msg = "移除tag:"
      Tag.find_all_by_id(@tagDelete).each do |tag| 
        @msg = @msg+ " "+tag.name
      end
      newTrack("log", @msg)
    end

    if(@tagCreate.length > 0 || params[:tagnew])
      @msg = "新增tag:"
      Tag.find_all_by_id(@tagCreate).each do |tag|
        @msg = @msg+ " "+tag.name
      end

      params[:tagnew] && params[:tagnew].each do |tag|
        @msg = @msg+ " "+tag
      end
      newTrack("log", @msg)
    end

    
    @ccDelete = @ccOld - (params[:cc]||Array.new)
    @ccCreate = (params[:cc]||Array.new) - @ccOld

    if(@ccDelete.length > 0)
      @msg = "刪除標記"
      User.find_all_by_id(@ccDelete).each do |user| 
        @msg = @msg+ " "+user.username
      end
      newTrack("log", @msg)
    end

    if(@ccCreate.length > 0)
      @msg = "新增標記了"
      User.find_all_by_id(@ccCreate).each do |user|
        @msg = @msg+ " " + user.username
      end
      newTrack("log", @msg)
    end

    respond_to do |format|
      @ticket.cc = (params[:cc]||Array.new).to_json
      @ticket.priority = params[:priority]

      @tickettagDel = Tickettag.where(:ticket_id => @ticket.id).find_all_by_tag_id(@tagDelete)
      @tickettagDel.each do |tickettag|
        Tickettag.find(tickettag.id).delete
      end

      @tagCreate && @tagCreate.each do |tag|
        @tickettag = Tickettag.new
        @tickettag.ticket_id = @ticket.id
        @tickettag.tag_id = tag
        @tickettag.save
      end

      params[:tagnew] && params[:tagnew].each do |tag|
        @tag = Tag.new
        @tag.name = tag

        if(@tag.save)
          @tickettag = Tickettag.new
          @tickettag.ticket_id = @ticket.id
          @tickettag.tag_id = @tag.id

          @tickettag.save
        end
      end

      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to ticket_path(@ticket), notice: 'ticket was successfully updated.' }
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

    newTrack("log", "重新開啟該回報。")

    respond_to do |format|
      format.html { redirect_to ticket_path(@ticket) }
      format.json { head :no_content }
    end
    
  end

  def close
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.status = "close"
    @ticket.save

    newTrack("log", "關閉該回報")

    newTrack("track", "關閉原因："+params[:track]["comment"]+"。")

    respond_to do |format|
      format.html { redirect_to ticket_path(@ticket) }
      format.json { head :no_content }
    end
  end

  def newTrack(status, comment)
    @track = @ticket.tracks.new
    @track.status = status
    @track.actor = current_user.id
    @track.comment = comment

    @track.save
  end
end
