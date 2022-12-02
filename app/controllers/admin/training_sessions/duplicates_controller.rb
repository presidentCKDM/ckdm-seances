class Admin::TrainingSessions::DuplicatesController  < Admin::ApplicationController

  before_action :set_training_session, only: [:create]

  def create
    DuplicateTrainingSession.call(@training_session)

    redirect_to admin_training_sessions_path
  end

  private

    def set_training_session
      @training_session = TrainingSession.find(params[:training_session_id])
    end
end
