# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.destroy_all

Client.create!(username: "AndreeaTestClient", password: "pass", name: "Test Client 1", street_address: "123 Test Rd", city: "Denver", state: "CO", zip: "80203", email: "test1@example.com", phone_number: "2465553421", needs: "Groceries, Bills", allergies: "Pollen, Latex", medications: "Vasodilator, Synthroid", diet_restrictions: "vegetarian, peanut-free")
