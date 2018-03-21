# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

italian = Category.where(name: "Italian").first_or_create(name: "Italian")
fancy = Category.where(name: "Fancy").first_or_create(name: "Fancy")
chinese = Category.where(name: "Chinese").first_or_create(name: "Chinese")
american = Category.where(name: "American").first_or_create(name: "American")
mexican = Category.where(name: "Mexican").first_or_create(name: "Mexican")
fast_food = Category.where(name: "Fast Food").first_or_create(name: "Fast Food")


25.times do
    Brewery.create!([{ 
        name: Faker::Name.name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        submitted_by: 1,
        }])
end