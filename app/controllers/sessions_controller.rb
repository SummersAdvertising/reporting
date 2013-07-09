class SessionsController < Devise::SessionsController
	layout false
	skip_before_filter :check_authorization, :only => [:new]

	def create
		self.resource = warden.authenticate!(auth_options)
		set_flash_message(:notice, :signed_in) if is_navigational_format?
		sign_in(resource_name, resource)
		
		respond_with resource, :location => after_sign_in_path_for(resource)
	end

	def destroy
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
		set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

		# We actually need to hardcode this as Rails default responder doesn't
		# support returning empty response on GET request
		respond_to do |format|
			format.all { head :no_content }
			format.any(*navigational_formats) { redirect_to new_user_session_path(:redirect_to => request.referrer) }
		end
	end
end