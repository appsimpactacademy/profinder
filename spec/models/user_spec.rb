require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) { build :user } 
    let(:user1) { create :user, state: nil }
    let(:user2) { build :user, email: user.email, contact_number: user.contact_number }

    it 'should be valid user with all attributes' do
      expect(user.valid?).to eq(true)
    end

    it 'should have state name as country name if the state is nil' do 
      expect(user1.state).to eq(user1.country)
    end

    it 'should raise invalid record exception for duplicate email and contact' do 
      user.save
      expect(user2.save).to eq(false)
      expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
