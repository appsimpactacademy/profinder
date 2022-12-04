require 'rails_helper'

RSpec.describe UsersController do 
  describe 'GET index' do 
    let(:user) { create :user }

    before(:each) do 
      sign_in(user)
      get :index
    end
    
    it 'assigns @users' do 
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the index template' do 
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do 
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do 
    let(:user) { create :user }

    before(:each) do 
      sign_in(user)
    end

    it 'should accepts the params with html format' do 
      post :create, params: {
        user: user_params
      }
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end

    it 'should accepts the params with turbo_stream format' do 
      post :create, params: {
        user: user_params,
        format: :turbo_stream
      }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
    end

    it 'should redirect to user showpage with html format' do 
      post :create, params: {
        user: user_params
      }
      expect(subject).to redirect_to(assigns(:user))
    end

    it 'should render the user partial with turbo_stream format' do 
      post :create, params: {
        user: user_params,
        format: :turbo_stream
      }
      expect(response).to render_template('users/_user')
    end

    it 'should renders the validation errors into form' do 
      post :create, params: {
        user: {
          name: nil,
          email: nil,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
    end

    it 'should includes the error messages for empty attributes' do 
      post :create, params: {
        user: {
          name: nil,
          email: nil,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
      expect(assigns(:user).errors.full_messages).to include("Email can't be blank", "Name can't be blank")
    end

    it 'should includes the uniqueness error in form' do 
      post :create, params: {
        user: {
          name: Faker::Name.name_with_middle,
          email: user.email,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
      expect(assigns(:user).errors.full_messages).to include("Email has already been taken")
    end
  end

  describe 'PATCH update' do
    let(:user) { create :user }

    before(:each) do 
      sign_in(user)
    end
  end
end

def user_params
  {
    name: Faker::Name.name_with_middle,
    email: Faker::Internet.email,
    password: 'password@123',
    contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
    country: User.country_code_list.sample,
    state: 'MP',
    city: 'Indore'
  }
end
