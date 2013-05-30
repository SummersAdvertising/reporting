class AutocompleteController < ApplicationController
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

  def getTags
    @tags = Array.new

    Tag.all.each do |tag|
      @tag = {"id" => tag.id, "label" => tag.name, "value" => tag.id}

      @tags.push(@tag)
    end

    respond_to do |format|
      format.json { render json: @tags}
    end
    
  end

  def getTopics
    @topics = Array.new

    Topic.all.each do |topic|
      @topics.push( {"id" => topic.id, "value" => topic.name} )
    end

    respond_to do |format|
      format.json { render json: @topics}
    end
    
  end
end