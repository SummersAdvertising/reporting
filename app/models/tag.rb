class Tag < ActiveRecord::Base
  attr_accessible :count, :name, :status
  
  validates_presence_of :name
  
  has_many :tickettags
  has_many :tickets, :through => :tickettags
  
  #before_save :set_default
  
private
	def set_default
		self.status = self.status | 'default'
		self.count = self.count | 0
	end
  
end
