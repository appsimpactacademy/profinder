require 'rails_helper'

RSpec.describe 'Delete user', type: :feature do
  let!(:user) { create(:user) }
  
  scenario 'should destroy the paticular user' do
    visit users_path
    page.accept_confirm do
      click_link("user-#{user.id}-delete")
	  end
    visit users_path
    page.should_not have_content(user.name)
  end
end
