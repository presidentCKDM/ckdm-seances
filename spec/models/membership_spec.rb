require 'rails_helper'

RSpec.describe Membership, type: :model do

	it { is_expected.to belong_to(:group) }
	it { is_expected.to validate_presence_of(:group) }

	it { is_expected.to belong_to(:user) }
	it { is_expected.to validate_presence_of(:user) }

	it "has a valid factory" do
		expect(build(:membership)).to be_valid
	end

end
