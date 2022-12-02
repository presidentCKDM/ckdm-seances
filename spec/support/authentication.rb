def sign_in_with(user)
  visit root_path

  click_on user.groups.first
	click_on user
end

def sign_out
	click_on "Changer"
end
