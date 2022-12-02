class DuplicateTrainingSession

	def self.call(training_session)
		new(training_session).call
	end

	attr_reader :training_session

	def initialize(training_session)
		@training_session = training_session
	end

	def call
		new_training_session = training_session.dup

		new_training_session.started_at = training_session.started_at + 7.days

		new_training_session.groups << training_session.groups

		new_training_session.save

		new_training_session
	end

	private

end