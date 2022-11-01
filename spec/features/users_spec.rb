require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:user) { create(:user, name: 'Testuser6') }

  scenario 'valid input#Create' do
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

  scenario 'invalid input#Create' do
    visit users_path
    click_link('New user')
    fill_in 'Name', with: ''
    fill_in 'Email', with: ''
    fill_in 'City', with: ''
    fill_in 'Contact', with: ''
    click_button 'Create User'
    within('#exampleModal') do
      page.should have_content('6 errors prohibited this user from being saved:')
      page.should have_content("Name can't be blank")
    end
  end

  scenario '#Index' do
    visit users_path
    page.should have_content('Users')
    page.should have_content(user.name)
    page.should have_content(user.email)
  end

  scenario '#Show' do
    visit users_path
    find(:css, 'i.bi.bi-eye').click
    within('#exampleModal') do
      page.should have_content('User Details')
      page.should have_content("Name: #{user.name}")
      page.should have_content("Email: #{user.email}")
    end
  end

  scenario '#Update' do
    visit users_path
    find(:css, 'i.bi.bi-pencil').click
    fill_in 'Name', with: 'Testuser90'
    within('#exampleModal') do
      click_button 'Update User'
    end
    visit users_path(user)
    expect(user.reload.name).to eq('Testuser90')
  end

  scenario '#Destroy' do
    visit users_path
    page.accept_confirm do
      click_link("user-#{user.id}-delete")
    end
    visit users_path
    page.should_not have_content(user.name)
  end
end
