# rake training_sessions:clean

namespace 'training_sessions' do
  desc "Clean old training sessions"
  task :clean => :environment do
    TrainingSession.in_the_past.destroy_all
  end
end
