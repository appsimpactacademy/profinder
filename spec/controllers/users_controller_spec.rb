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
end