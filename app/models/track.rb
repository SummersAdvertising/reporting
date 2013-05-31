class Track < ActiveRecord::Base
  attr_accessible :actor, :comment, :status, :ticket_id, :type
  validates :comment, :presence => true
  
  belongs_to :ticket
  belongs_to :user
  
end
