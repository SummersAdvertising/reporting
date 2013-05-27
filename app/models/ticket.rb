class Ticket < ActiveRecord::Base
  attr_accessible :close_time, :deadline, :description, :period, :reporter, :status, :title, :topic, :treatment, :priority
  
  # has_and_belongs_to_many :tags
  has_many :tracks
  belongs_to :topic
  
end
