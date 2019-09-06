FactoryBot.define do
  factory :task do
    name { Faker::Food.ingredient }
    description { Faker::Food.measurement }
    completed { false }
    due_date { Faker::Date.forward(days: 23) }
  end
end
