FactoryBot.define do
  factory :client do
    sequence :username {|n| "username#{n}"}
    sequence :name {|n| "User#{n}"}
    street_address { '123 Test St' }
    city { 'Testville' }
    state { 'CO' }
    zip { '12345' }
    sequence :email {|n| "email#{n}@example.com" }
    phone_number { '1235551234' }
    needs { 'Grocery, Bills' }
    allergies { 'Pollen, Ibuprofen' }
    medications { 'test_drug1, test_drug2' }
  end
end
