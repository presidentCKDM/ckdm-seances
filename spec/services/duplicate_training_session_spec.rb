require 'rails_helper'

RSpec.describe DuplicateTrainingSession, type: :model do

	let(:training_session) { create :training_session }
	let(:duplicated_training_session) { DuplicateTrainingSession.call(training_session) }
	let(:group) { create :group }

	before do
		training_session.groups << group
	end

	it "has a valid factory" do
		expect(duplicated_training_session.groups).to eq training_session.groups
		expect(duplicated_training_session.location).to eq training_session.location
		expect(duplicated_training_session.started_at).to eq training_session.started_at + 7.days
	end
end