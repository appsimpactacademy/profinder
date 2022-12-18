require 'rails_helper'

RSpec.describe UsersController do 

  let(:user) { create :user }
    
  before(:each) do 
    sign_in(user)
  end

  describe 'GET index' do 
    it 'assigns @users' do 
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the index template' do 
      get :index
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do 
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do 
    
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
    let(:user1) { create :user }
    let(:user2) { create :user }

    it 'should accepts the params with html format' do 
      patch :update, params: {
        user: user_params,
        id: user1.id
      }
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end

    it 'should accepts the params with turbo_stream format' do 
      patch :update, params: {
        user: user_params,
        id: user1.id,
        format: :turbo_stream
      }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
    end

    it 'should redirect to user showpage with html format' do 
      patch :update, params: {
        user: user_params,
        id: user2.id
      }
      expect(subject).to redirect_to(assigns(:user))
    end

    it 'should render the user partial with turbo_stream format' do 
      patch :update, params: {
        user: user_params,
        id: user2.id,
        format: :turbo_stream
      }
      expect(response).to render_template('users/_user')
    end

    it 'should renders the validation errors into form' do 
      patch :update, params: {
        user: {
          name: nil,
          email: nil,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        id: user2.id,
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
    end

    it 'should includes the error messages for empty attributes' do 
      patch :update, params: {
        user: {
          name: nil,
          email: nil,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        id: user1.id,
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
      expect(assigns(:user).errors.full_messages).to include("Email can't be blank", "Name can't be blank")
    end

    it 'should includes the uniqueness error in form' do 
      patch :update, params: {
        user: {
          name: Faker::Name.name_with_middle,
          email: user.email,
          password: 'password@123',
          contact_number: Faker::PhoneNumber.cell_phone_with_country_code,
          country: User.country_code_list.sample,
          state: 'MP',
          city: 'Indore'
        },
        id: user1.id,
        format: :turbo_stream
      }
      expect(assigns(:user).valid?).to_not eq(true)
      expect(response).to render_template('users/_modal')
      expect(assigns(:user).errors.full_messages).to include("Email has already been taken")
    end

  end

  describe 'DELETE destroy' do 
    let(:user1) { create :user }
    
    it 'should reduce the user count by one' do 
      delete :destroy, params: {
        id: user1.id,
        format: :turbo_stream
      }
      expect(User.count).to eq(1)
    end

    it 'should not render any template with turbo_stream format' do
      delete :destroy, params: {
        id: user1.id,
        format: :turbo_stream
      }
      expect(response).to render_template(nil)
    end

    it 'should redirect to users imdex page after deleting a user' do 
      delete :destroy, params: {
        id: user1.id
      }
      expect(subject).to redirect_to(users_path)
    end
  end

  describe 'GET show' do 
    let(:user1) { create :user }
    
    it 'should render the show template of user' do 
      get :show, params: {
        id: user1.id,
        format: :turbo_stream
      }
      expect(response).to render_template('users/show')
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
    end
  end

  describe 'GET edit' do 
    let(:user1) { create :user }
    
    it 'should render the edit template of user' do 
      get :edit, params: {
        id: user1.id,
        format: :turbo_stream
      }
      expect(response).to render_template('users/edit')
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
    end
  end

  describe 'GET new' do 
    
    it 'should render the new template of user' do 
      get :new, params: {
        format: :turbo_stream
      }
      expect(response).to render_template('users/new')
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response.content_type).to eq('text/vnd.turbo-stream.html; charset=utf-8')
    end
  end

  describe 'GET custom actions' do 

    it 'should return states as nil with invalid country code' do
      get :fetch_country_states, params: {
        country_code: 'abc',
        format: :turbo_stream
      }
      expect(assigns[:states]).to eq(nil)
    end

    it 'should return states count with valid country code' do
      get :fetch_country_states, params: {
        country_code: 'IN',
        format: :turbo_stream
      }
      expect(assigns[:states].count).to eq(40)
    end

    it 'should include a given state of the valid country' do
      get :fetch_country_states, params: {
        country_code: 'IN',
        format: :turbo_stream
      }
      expect(assigns[:states]).to include(['MP', 'Madhya Pradesh'])
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
