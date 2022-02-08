# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 5.times do 
#   Merchant.create!(
#     name: Faker::FunnyName.name
#   )
# end 
# 10.times do 
#   Item.create!(
#     name: Faker::Item.name,
#     description: Faker::Item.description,
#     unit_price: Faker::Item.unit_price 
#   )
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)