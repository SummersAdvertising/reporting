class TracksController < ApplicationController
	def create
		@track = Ticket.find(params[:ticket_id]).tracks.new(params[:track])
		@track.status = "track"
		@track["actor"] = current_user.id

		@track.save

		respond_to do |format|
			format.html { redirect_to ticket_path(params[:ticket_id]) }
			format.json { render json: @track.errors, status: :unprocessable_entity }
		end
    end
end