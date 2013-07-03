# encoding: utf-8
class Ticket < ActiveRecord::Base
  attr_accessible :close_time, :deadline, :description, :period, :reporter, :status, :title, :topic_id, :treatment, :priority
  validates :description, :topic_id, :presence => true
  
  has_many :tracks, :dependent => :destroy
  belongs_to :topic, :counter_cache => :count
  belongs_to :user, :foreign_key => :reporter

  has_many :tickettags, :dependent => :destroy
  has_many :tags, :through => :tickettags
  
  after_create :init_track
  
  def init_track
  	self.newTrack('log', '建立於' + Time.now.to_date.to_s)
  end
  
  
  def newTrack(status, comment)
  
    track = self.tracks.new
    track.status = status
    track.actor = self.user.id
    track.comment = comment

    track.save
  end
  
end