class Topic < ActiveRecord::Base
  attr_accessible :count, :name, :status, :color
  has_many :tickets
  has_many :subscribes
  has_many :users, :through => :subscribes

  has_many :tracks
end
