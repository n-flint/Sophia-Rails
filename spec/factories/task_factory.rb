FactoryBot.define do
  factory :task do
    name { Faker::Food.ingredient }
    description { Faker::Food.measurement }
    completed { false }
    due_date { Date.tomorrow }
  end
end
