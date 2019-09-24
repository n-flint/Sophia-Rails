FactoryBot.define do
  factory :caretaker do
    sequence :username {|n| "username#{n}"}
    password { 'password' }
    abilities { 'grocery, health consultant' }
    role { 'caretaker' }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
