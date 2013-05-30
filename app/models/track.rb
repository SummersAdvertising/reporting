class Track < ActiveRecord::Base
  attr_accessible :actor, :comment, :status, :ticket_id, :type
  
  belongs_to :ticket
  belongs_to :user
  
end
