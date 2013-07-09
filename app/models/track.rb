class Track < ActiveRecord::Base
  attr_accessible :actor, :comment, :status, :ticket_id, :type
  validates :comment, :presence => true
  
  belongs_to :ticket
  belongs_to :user
  
  after_create :send_message
  
  def send_message
  	TrackMailer.delay.send_notify(self)
  	TrackMailer.delay.send_cc(self)
  	#TrackMailer.send_notify(self.ticket).deliver
  end
  
end
