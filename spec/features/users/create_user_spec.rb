require 'rails_helper'

RSpec.describe 'Create user', type: :feature do
  let!(:user) { create(:user) }

  scenario 'with valid input' do
    visit users_path
    click_link('New user')
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'testuser@gmail.com'
    fill_in 'City', with: 'Test City'
    find(:css, '#user_country').find(:option, 'India').select_option
    fill_in 'Contact', with: '97747897899'
    click_button 'Create User'
    visit users_path
	end
end
