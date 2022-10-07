FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    contact_number { Faker::PhoneNumber.cell_phone_with_country_code }
    country { 'India' }
    state { 'MP' }
    city { 'Indore' }
  end
end
