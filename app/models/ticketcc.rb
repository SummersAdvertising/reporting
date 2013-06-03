class Ticketcc < ActiveRecord::Base
  attr_accessible :ticket_id, :user_id
  validates_uniqueness_of :user_id, :scope => [:ticket_id]
  
  belongs_to :ticket
  belongs_to :user
end
