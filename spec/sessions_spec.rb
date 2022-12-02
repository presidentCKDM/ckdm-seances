require 'rails_helper'

RSpec.describe "managing sessions", type: :feature do

  let(:group)       { create :group }
  let(:user)        { create :user, groups: [group] }
  let(:admin_user)  { create :admin_user, groups: [group] }

  it "can login" do
    sign_in_with user

    expect(page).to have_content("Connecté en tant que #{user}")
  end

  it "can logout" do
    sign_in_with user
    sign_out

    expect(page).to have_content("Se connecter")
  end


  it "can login as an admin" do
    sign_in_with admin_user

    expect(page).to have_content("Equipes")
  end

end