class SessionsController < ApplicationController


	def new

    if group_id = params[:group_id] and @selected_group = Group.find(group_id)
      @groups = []
      @users = @selected_group.users.order("name ASC")
    else
      @users = []
      @groups = Group.all.order("name ASC")
    end


	end

  def create
    user = User.find params[:session][:user_id]
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)

    redirect_to new_session_path
  end

end