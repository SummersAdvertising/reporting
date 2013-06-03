class Ticket < ActiveRecord::Base
  attr_accessible :close_time, :deadline, :description, :period, :reporter, :status, :title, :topic_id, :treatment, :priority
  validates :description, :presence => true
  
  has_many :tracks, :dependent => :destroy
  belongs_to :topic, :counter_cache => :count

  has_many :tickettags, :dependent => :destroy
  has_many :tags, :through => :tickettags

  has_many :ticketccs, :dependent => :destroy
  has_many :users, :through => :ticketccs
end
