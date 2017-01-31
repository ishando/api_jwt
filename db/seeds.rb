# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

clients = Client.create([{ name: 'Client01' }, { name: 'Client02' }])
puts "Created #{Client.count} Clients"

admin = Admin.create([{ username: 'Admin01', password: 'test1234', password_confirmation: 'test1234' }])
puts "Created #{Admin.count} Admins"
