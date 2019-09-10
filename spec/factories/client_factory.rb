FactoryBot.define do
  factory :client do
    sequence :username {|n| "username#{n}"}
    password { 'password' }
    name { Faker::Name.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    needs { 'Grocery, Bills' }
    allergies { 'Pollen, Ibuprofen' }
    medications { 'test_drug1, test_drug2' }
    diet_restrictions { 'vegetarian, peanut-free' }
  end
end
