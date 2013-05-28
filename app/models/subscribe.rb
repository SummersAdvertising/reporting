class Subscribe < ActiveRecord::Base
  attr_accessible :topic_id, :user_id
  validates_uniqueness_of :topic_id, :scope => [:user_id]
  
  belongs_to :user
  belongs_to :topic
end
