class Log < ActiveRecord::Base
  attr_accessible :action, :actor, :content, :controller, :type
end
