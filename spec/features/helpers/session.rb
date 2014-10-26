module SessionHelpers

	def sign_in(username, password)
			visit '/sessions/new'
			fill_in 'username', :with => username
			fill_in 'password', :with => password
			click_button 'Sign in'
	end

	def sign_up(name = "Elena Garrone",
				username = "elena15",
				email = "elena@example.com",
				password = "elena",
				password_confirmation = "elena")
		visit 'users/new'
		expect(page.status_code).to eq(200)
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end


	def add_peep(message)
		within('#new-peep') do
			fill_in 'peep', :with => message
			click_button 'Add peep'
		end
	end
	
end