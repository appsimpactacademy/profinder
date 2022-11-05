FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password { 'password@123' }
    contact_number { Faker::PhoneNumber.cell_phone_with_country_code }
    country { User.country_code_list.sample }
    state { 'MP' }
    city { 'Indore' }
  end
end
