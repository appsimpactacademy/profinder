# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
100.times do |i|
  User.create(
    name: Faker::Name.name_with_middle,
    email: Faker::Internet.email,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    contact_number: Faker::PhoneNumber.phone_number_with_country_code
  )
end

FrontEndSkill.find_or_create_by(name: 'HTML')
FrontEndSkill.find_or_create_by(name: 'CSS3')
FrontEndSkill.find_or_create_by(name: 'JavaScript')
FrontEndSkill.find_or_create_by(name: 'JQuery')
FrontEndSkill.find_or_create_by(name: 'Twitter Bootstrap')
FrontEndSkill.find_or_create_by(name: 'React JS')
FrontEndSkill.find_or_create_by(name: 'Angular JS')
FrontEndSkill.find_or_create_by(name: 'Vue JS')

BackEndSkill.find_or_create_by(name: 'Ruby')
BackEndSkill.find_or_create_by(name: 'Rails')
BackEndSkill.find_or_create_by(name: 'Java')
BackEndSkill.find_or_create_by(name: 'Node JS')
BackEndSkill.find_or_create_by(name: 'Python')
BackEndSkill.find_or_create_by(name: 'PHP/Laravel')
BackEndSkill.find_or_create_by(name: 'Postgresql')
BackEndSkill.find_or_create_by(name: 'MySQL')
BackEndSkill.find_or_create_by(name: 'MongoDB')
BackEndSkill.find_or_create_by(name: 'CURL')
BackEndSkill.find_or_create_by(name: 'REST Api')

UserSkill.create(user: User.first, skill: Skill.find(1), rating: 8)
UserSkill.create(user: User.first, skill: Skill.find(3), rating: 8)
UserSkill.create(user: User.first, skill: Skill.find(4), rating: 8)
UserSkill.create(user: User.first, skill: Skill.find(5), rating: 8)
UserSkill.create(user: User.first, skill: Skill.find(8), rating: 8)

UserSkill.create(user: User.last, skill: Skill.find(1), rating: 8)
UserSkill.create(user: User.last, skill: Skill.find(4), rating: 8)
UserSkill.create(user: User.last, skill: Skill.find(8), rating: 8)
UserSkill.create(user: User.last, skill: Skill.find(6), rating: 8)
UserSkill.create(user: User.last, skill: Skill.find(7), rating: 8)
UserSkill.create(user: User.last, skill: Skill.find(9), rating: 8)