class AdminController < ApplicationController
	before_filter :is_admin
	
	def index
		respond_to do | format |
		end
	end	
end