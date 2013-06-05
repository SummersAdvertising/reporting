class Admin::UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(params[:user])

		respond_to do |format|
			if(@user.save)
				format.html { redirect_to admin_users_path }
				format.json { render json: @user, status: :unprocessable_entity }
			else
				format.html { render "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end
	def destroy
		exit
		
	end
end