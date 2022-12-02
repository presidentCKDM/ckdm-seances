class Admin::UsersController  < Admin::ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    load_users
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      load_and_render_index
    else
      render action: 'new'
    end

  end

  def update
    if @user.update(user_params)
      load_and_render_index
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy

    load_and_render_index
  end

  private

    def load_users
      @users = User.all.order("name ASC")
    end

    def load_and_render_index
      load_users
      render :index, change: "users"
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone, group_ids: [])
    end
end
