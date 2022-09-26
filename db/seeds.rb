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