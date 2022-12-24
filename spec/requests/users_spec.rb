require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { create :user }
    
  before(:each) do 
    sign_in(user)
  end

  describe "GET /users" do
    it 'should return the status code 200' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Create user' do 
    it 'should render the new user form and then save the data into database' do
      get new_user_path(format: :turbo_stream)
      expect(response).to render_template('users/new')

      post users_path, params: {
        user: {
          name: Faker::Name.name_with_middle,
          email: Faker::Internet.email,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        format: :turbo_stream
      }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
      expect(User.count).to eq(2)
      expect(response).to render_template('users/_user')
    end
  end

  describe 'Update user' do 
    let(:user1) { create :user }

    it 'should render the edit user form and then update the data into database' do
      get edit_user_path(user1, format: :turbo_stream)
      expect(response).to render_template('users/edit')

      patch user_path(user1), params: {
        user: {
          name: 'Updated Name',
          contact_number: '+00 1234567890'
        },
        format: :turbo_stream
      }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
      expect(User.count).to eq(2)
      expect(response).to render_template('users/_user')
      expect(assigns[:user].name).to eq('Updated Name')
      expect(assigns[:user].contact_number).to eq('+00 1234567890')
    end
  end
end
