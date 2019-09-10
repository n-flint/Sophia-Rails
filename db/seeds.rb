# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.destroy_all
List.destroy_all
Task.destroy_all

test_client = Client.create!(username: "AndreeaTestClient", password: "pass", name: "Test Client 1", street_address: "123 Test Rd", city: "Denver", state: "CO", zip: "80203", email: "test1@example.com", phone_number: "2465553421", needs: "Groceries, Bills", allergies: "Pollen, Latex", medications: "Vasodilator, Synthroid", diet_restrictions: "vegetarian, peanut-free")
grocery_list = test_client.lists.create!(name: "Groceries")
Task.create!([
  {
    name: "Gala Apples",
    description: "Should be on sale",
    completed: false,
    list: grocery_list
  },
  {
    name: "Green Onions",
    description: "Should be on sale",
    completed: false,
    list: grocery_list
  },
  {
    name: "Garlic",
    description: "3 heads please",
    completed: false,
    list: grocery_list
  },
  {
    name: "Bread",
    description: "Wonder",
    completed: false,
    list: grocery_list
  }
])
dinner_party_errands = test_client.lists.create!(name: "Dinner Party Errands")
Task.create!([
  {
    name: "Get Present for Dayna",
    description: "Text me a picture of the Necklace I told you about",
    completed: false,
    due_date: Date.new + 3.days,
    list: dinner_party_errands
  },
  {
    name: "Get White Napkins",
    description: '12" X 12"',
    completed: false,
    due_date: Date.new + 3.days,
    list: dinner_party_errands
  },
  {
    name: "Clean and prepare Dining Room",
    description: "Please make sure there's enough chairs",
    completed: false,
    due_date: Date.new + 3.days,
    list: dinner_party_errands
  }
])
