require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "In order to see what people have to say, I want to see all peeps: " do
	before(:each) {
		Peep.create(:message => "Hi everyone!")
	}

	scenario "when opening the homepage" do
		visit'/'
		sign_up
		add_peep("Hi everyone!")
		expect(page).to have_content("Hi everyone!")
	end
end


context "In order to use chitter as a maker I want to: " do
	
	feature "sign up to the service" do
		scenario "when being logged out" do
			expect{sign_up}.to change(User, :count).by(1)
			expect(page).to have_content("CHITTER")
			expect(User.first.username).to eq("elena15")
		end

		scenario "with a password that doesn't match" do
			expect{sign_up('e@e.com', 'pass', 'tra', 'username')}.to change(User, :count).by (0)
		end

		scenario "with a password that doesn't match" do
			expect{sign_up('e@e.com', 'pass', 'tra', 'username')}.to change(User, :count).by (0)
			expect(current_path).to eq('/users')
			expect(page).to have_content("Sorry, your passwords don't match")
		end

		scenario "with an email that is already registered" do
			expect{sign_up}.to change(User, :count).by(1)
			expect{sign_up}.to change(User, :count).by(0)
			expect(page).to have_content("This email is already taken")
		end

		scenario "with a username that is already taken" do
			expect{sign_up}.to change(User, :count).by(1)
			expect{sign_up}.to change(User, :count).by(0)
			expect(page).to have_content("This username is already taken")
		end

	end

	feature "sign in" do

		before(:each) do
			User.create(:name => "Elena Garrone",
						:username => "elena15",
						:email => "elena@example.com",
						:password => "elena",
						:password_confirmation => "elena")
		end

		scenario "with correct credentials" do
			visit '/'
			expect(page).not_to have_content("Welcome, elena15")
			sign_in('elena15', 'elena')
			expect(page).to have_content("Welcome, elena15")
		end

		scenario "with incorrect credentials" do
			visit '/'
			expect(page).not_to have_content("Welcome, elena15")
			sign_in('elena15', 'wrong')
			expect(page).not_to have_content("Welcome, elena15")
		end

	end		

	feature "sign out" do

		before(:each) do
			User.create(:name => "Elena Garrone",
						:username => "elena15",
						:email => "elena@example.com",
						:password => "elena",
						:password_confirmation => "elena")
		end

		scenario "while being signed in" do
			sign_in('elena15', 'elena')
			click_button "Sign out"
			expect(page).to have_content("Good bye!")
			expect(page).not_to have_content("Welcome, elena15")
		end
	end

end