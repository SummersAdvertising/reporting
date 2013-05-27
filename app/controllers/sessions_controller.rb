class SessionsController < Devise::SessionsController
  skip_before_filter :check_authorization, :only => [:new]
end