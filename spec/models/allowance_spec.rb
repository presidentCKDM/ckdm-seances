require 'rails_helper'

RSpec.describe Allowance, type: :model do
  it { is_expected.to belong_to(:group) }
	it { is_expected.to validate_presence_of(:group) }

	it { is_expected.to belong_to(:training_session) }
	it { is_expected.to validate_presence_of(:training_session) }

	it "has a valid factory" do
		expect(build(:allowance)).to be_valid
	end

	context 'data coherence' do
		it "validates [:group, :training_session] uniqueness" do
			allowance = create :allowance

			expect(build(:allowance, group: allowance.group, training_session: allowance.training_session)).not_to be_valid
		end
	end

	context 'invitations management' do
		context 'on create' do
			before(:each) do
			  @group = create :group
			  @another_group = create :group
			  @user = create :user
			  @user.groups << @group

			  @training_session = create :training_session
			end

			it "does nothing if no users" do
				expect{
					create :allowance, group: @another_group, training_session: @training_session
				}.not_to change(Invitation, :count)
			end

			it "creates invitations for all group's users" do
				expect{
					create :allowance, group: @group, training_session: @training_session
					@training_session.update_invitations
				}.to change(Invitation, :count).by(1)

				expect(@user.training_sessions.reload).to include(@training_session)
			end
		end

		context 'on delete' do
			before(:each) do
			  @group = create :group
			  @another_group = create :group
			  @user = create :user
			  @user.groups << @group

			  @training_session = create :training_session
			  @allowance = create :allowance, group: @group, training_session: @training_session

			  @user.update_invitations
			end

			it "destroy invitations for all group's users" do
				expect{
					@allowance.destroy
					@training_session.update_invitations
				}.to change(Invitation, :count).by(-1)

				expect(@user.training_sessions.reload).not_to include(@training_session)
			end

		end
	end
end
