class AdminController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		respond_to do | format |
		end
	end
	
end