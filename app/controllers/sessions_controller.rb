class SessionsController < Devise::SessionsController
	layout false
	skip_before_filter :check_authorization, :only => [:new]
end