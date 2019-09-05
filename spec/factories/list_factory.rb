FactoryBot.define do
  factory :list do
    sequence :name {|n| "list name #{n}" }
  end
end
