FactoryBot.define do
  factory :task do
    sequence :name {|n| "task name #{n}" }
    description { "task description" }
    completed { false }
    due_date { Date.tomorrow }
  end
end
