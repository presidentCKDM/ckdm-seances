class InvitationsController < ApplicationController

	def update
    @invitation = current_user.invitations.find params[:id]
    @invitation.update_attributes invitation_params
  end

  private

    def invitation_params
      params.require(:invitation).permit(:is_confirmed)
    end
end