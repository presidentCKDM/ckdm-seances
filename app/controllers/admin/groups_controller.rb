class Admin::GroupsController  < Admin::ApplicationController

  before_action :set_group, only: [:edit, :update]

  def index
    load_groups
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      load_and_render_index
    else
      render action: 'new'
    end

  end

  def update
    if @group.update(group_params)
      load_and_render_index
    else
      render action: 'edit'
    end
  end

  private

    def load_groups
      @groups = Group.all.order("name ASC")
    end

    def load_and_render_index
      load_groups
      render :index, change: "groups"
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name)
    end
end
