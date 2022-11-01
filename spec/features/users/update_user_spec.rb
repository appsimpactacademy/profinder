require 'rails_helper'

RSpec.describe 'Update user', type: :feature do
  let!(:user) { create(:user, name: 'Testuser6') }

  
  scenario 'with valid input' do
    visit users_path
    click_link("user-#{user.id}-edit")
    fill_in 'Name', with: 'Testuser90'
    within('#exampleModal') do
      click_button 'Update User'
    end
    visit users_path(user)
    expect(user.reload.name).to eq('Testuser90')
  end
end
