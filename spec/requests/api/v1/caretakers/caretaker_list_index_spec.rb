require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can get an index of all the lists for a caretaker' do
    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno', 
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1'
    })

    @client_1 = Client.create!({
                "username": "existing_user",
                "password": "pass",
                "name": "name1",
                "street_address": "123 Fake St.",
                "city": "Denver",
                "state": "CO",
                "zip": "80203",
                "email": "example@email.com",
                "phone_number": "246342176",
                "needs": "Grocery, Bills",
                "allergies": "Pollen, Hard-Work",
                "medications": "Cannabis",
                "diet_restrictions": "vegetarian, peanut-free"
    })

    list_1 = create(:list, caretaker_id: @caretaker_1.id, client_id: @client_1.id)
    list_2 = create(:list, caretaker_id: @caretaker_1.id, client_id: @client_1.id)
    list_3 = create(:list, client_id: @client_1.id)

    headers = { 'CONTENT_TYPE' => 'application/json'}
    get "/api/v1/caretakers/#{@caretaker_1.id}/lists", headers: headers

    data = JSON.parse(response.body)

    require 'pry'; binding.pry



    # expect(@caretaker_1.lists.count).to eq(2)
    # expect(@caretaker_1.lists[0].name).to eq('list name 1')
    # expect(@caretaker_1.lists[1].name).to eq('list name 2')
  end 
end