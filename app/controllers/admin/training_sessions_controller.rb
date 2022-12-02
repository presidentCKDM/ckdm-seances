class Admin::TrainingSessionsController  < Admin::ApplicationController

  before_action :set_training_session, only: [:edit, :update, :destroy]

  def index
    load_training_sessions
  end

  def new
    @training_session = TrainingSession.new started_at: Date.today.to_time.change({hour: 20, min: 30})
  end

  def create
    @training_session = TrainingSession.new(training_session_params)

    if @training_session.save
      load_and_render_index
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @training_session.update(training_session_params)
      load_and_render_index
    else
      render action: 'edit'
    end
  end

  def destroy
    @training_session.destroy

    load_and_render_index
  end

  private

    def load_training_sessions
      @training_sessions = TrainingSession.to_come.order("started_at ASC")
    end

    def load_and_render_index
      load_training_sessions
      render :index, change: "training_sessions"
    end

    def set_training_session
      @training_session = TrainingSession.find(params[:id])
    end

    def training_session_params
      params.require(:training_session).permit(:description, :started_at, :location_id, group_ids: [])
    end
end
