class Admin::LocationsController  < Admin::ApplicationController

  before_action :set_location, only: [:edit, :update]

  def index
    load_locations
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      load_and_render_index
    else
      render action: 'new'
    end
  end

  def update
    if @location.update(location_params)
      load_and_render_index
    else
      render action: 'edit'
    end
  end

  private

    def load_locations
      @locations = Location.all.order("name ASC")
    end

    def load_and_render_index
      load_locations
      render :index, change: "locations"
    end

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name)
    end
end
