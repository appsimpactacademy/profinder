FactoryBot.define do
  factory :skill do
    name { "MyString" }
    type { "" }
  end

  factory :front_end_skill, class: FrontEndSkill do 
    name { 'HTML' }
  end

  factory :back_end_skill, class: BackEndSkill do 
    name { 'Ruby' }
  end
end
