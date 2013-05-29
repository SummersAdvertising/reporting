class Ticket < ActiveRecord::Base
  attr_accessible :close_time, :deadline, :description, :period, :reporter, :status, :title, :topic_id, :treatment, :priority
  
  # has_and_belongs_to_many :tags
  has_many :tracks
  belongs_to :topic

  has_many :tickettags
  has_many :tags, :through => :tickettags
end
