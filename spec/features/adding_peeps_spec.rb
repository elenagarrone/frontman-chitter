require 'spec_helper'
require_relative 'helpers/session'

feature "User post a new peep" do

	before(:each) do
		sign_up
	end

	scenario "when browsing the homepage" do
		expect(Peep.count).to eq(0)
		visit '/'
		add_peep("Hi everyone!")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("Hi everyone!")
	end

end

