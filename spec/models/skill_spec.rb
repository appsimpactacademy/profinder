require 'rails_helper'

RSpec.describe Skill, type: :model do
  context 'When creating a skill' do 
    let(:skill) { create :skill }
    let(:front_skill) { create :front_end_skill }
    let(:back_skill) { create :back_end_skill }

    it 'should have a type for front end skill' do 
      expect(front_skill.id).to_not eq(nil)
      expect(front_skill.type).to eq('FrontEndSkill')
    end

    it 'should have a type for back end skill' do 
      expect(back_skill.id).to_not eq(nil)
      expect(back_skill.type).to eq('BackEndSkill')
    end

    it 'should raise the active record exception if type is empty' do 
      expect{skill}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
