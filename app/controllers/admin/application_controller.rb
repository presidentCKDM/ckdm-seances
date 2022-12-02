class Admin::ApplicationController < ApplicationController

  private
    def authenticate_admin_user!
      authenticate_user!
      raise UnauthorizedSession unless current_user.is_admin?
    end
end
