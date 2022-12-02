class Users::InvitationsController < ApplicationController

	def index
		invitations = current_user.invitations

		respond_to do |format|
    	format.json { render json: invitations }
    	format.ics do
	      calendar = ConvertToIcs.call(invitations)
	      render text: calendar.to_ical
    	end
  	end
	end

	private
		def current_user
			User.find_by(token: params[:token])
		end
end