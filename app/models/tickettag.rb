class Tickettag < ActiveRecord::Base
  attr_accessible :tag_id, :ticket_id
  belongs_to :ticket
  belongs_to :tag
end
