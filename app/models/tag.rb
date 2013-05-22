class Tag < ActiveRecord::Base
  attr_accessible :count, :name, :status
  
  validates_presence_of :name
  
  has_and_belongs_to_many :tickets
  
  before_save :set_default
  
private
	def set_default
		self.status = self.status | 'default'
		self.count = self.count | 0
	end
  
end
