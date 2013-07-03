class Topic < ActiveRecord::Base
  attr_accessible :count, :name, :status, :color
  validates :name, :presence => true
  validates :name, :uniqueness => true
  
  has_many :tickets
  has_many :subscribes
  has_many :users, :through => :subscribes

  has_many :tracks
  
  def get_user_emails
  	
  	mails = []
  
  	self.subscribes.each do | s |
  		mails.push( s.user.email )
  	end
  	
  	mails
  end
  
end
