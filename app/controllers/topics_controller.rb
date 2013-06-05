class TopicsController < ApplicationController
  def index
    @topic = Topic.new
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { redirect_to topics_path }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to topics_path, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to topics_path }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    
    if(@topic.destroy)
      Subscribe.delete(Subscribe.where(:topic_id => params[:id]))
      Ticket.update_all( "topic_id = 0", ("topic_id = "+params[:id]) )
    end

    respond_to do |format|
      format.html { redirect_to topics_path }
      format.json { head :no_content }
    end
  end
end
