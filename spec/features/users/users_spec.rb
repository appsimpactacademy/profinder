require 'rails_helper'

RSpec.describe 'Users index', type: :feature do
  let!(:user) { create(:user) }

  scenario 'Users lists' do
    visit users_path
    page.should have_content('Users')
    page.should have_content(user.name)
    page.should have_content(user.email)
  end
end
