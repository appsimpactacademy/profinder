require 'rails_helper'

RSpec.describe 'Users show', type: :feature do
  let!(:user) { create(:user) }

  scenario 'get particular user' do
    visit users_path
    click_link("user-#{user.id}")
    within('#exampleModal') do
	    page.should have_content('User Details')
	    page.should have_content("Name: #{user.name}")
	    page.should have_content("Email: #{user.email}")
	  end
  end
end
