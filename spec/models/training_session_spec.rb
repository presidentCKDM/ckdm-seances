require 'rails_helper'

RSpec.describe TrainingSession, type: :model do
	it { is_expected.to validate_presence_of(:started_at) }

  it { is_expected.to belong_to(:location) }
	it { is_expected.to validate_presence_of(:location) }

	it { is_expected.to have_many(:allowances).dependent(:destroy) }
	it { is_expected.to have_many(:groups) }

	it { is_expected.to have_many(:invitations).dependent(:destroy) }
	it { is_expected.to have_many(:users) }

	it "has a valid factory" do
		expect(build(:training_session)).to be_valid
	end

	context 'creating a training_session' do
		let(:group) 						{ create :group }
		let(:user_1) 						{ create :user }
		let(:user_2) 						{ create :user }
		let(:user_3) 						{ create :user }
		let(:training_session) 	{ create :training_session }

		before do
		  user_1.groups << group
		  user_2.groups << group
		  user_3.groups << group
		end

		it "creates the invitations" do
			expect{
				training_session.groups << group
				training_session.update_invitations
			}.to change(user_1.invitations, :count).by(1)
		end

		it "creates the invitations" do

			another_training_session = build :training_session

			params = {
				started_at: another_training_session.started_at,
				location: another_training_session.location,
				allowances_attributes: [
					{_destroy: false, training_session: nil, group_id: group.id}
				]
			}
			expect{
				TrainingSession.create(params)
			}.to change(user_1.invitations, :count).by(1)
		end
	end

	context 'counters' do
		let(:training_session) { create :training_session }

		before(:each) do
		  create :invitation, training_session: training_session, is_confirmed: true
		  create :invitation, training_session: training_session, is_confirmed: true
		  create :invitation, training_session: training_session, is_confirmed: false, is_answered: true
		  create :invitation, training_session: training_session
		end

		it "knows about the number of attendes" do
			expect(training_session.is_expected_counter).to eq 2
			expect(training_session.is_not_expected_counter).to eq 1
			expect(training_session.has_not_answered_counter).to eq 1
		end
	end

	context 'cleaning old training sessions' do
		let!(:training_session) { create :training_session, started_at: 2.days.from_now }
		let!(:old_training_session) { create :training_session, started_at: 2.days.ago }

		it "selects old training sessions" do
			expect(TrainingSession.in_the_past).to eq([old_training_session])
		end

	end
end
