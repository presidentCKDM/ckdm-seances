require 'rails_helper'

RSpec.describe Group, type: :model do
	it { is_expected.to validate_presence_of(:name) }

	it { is_expected.to have_many(:allowances).dependent(:destroy) }
	it { is_expected.to have_many(:training_sessions) }

	it { is_expected.to have_many(:memberships).dependent(:destroy) }
	it { is_expected.to have_many(:users) }

	it "has a valid factory" do
		expect(build(:group)).to be_valid
	end

end