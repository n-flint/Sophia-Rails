require 'rails_helper'

RSpec.describe 'Clients API' do
  it 'can create a new client profile' do
    new_user = {
                "username": "username1",
                "name": "name1",
                "street_address": "123 Fake St.",
                "city": "Denver",
                "state": "CO",
                "zip": "80203",
                "email": "example@email.com",
                "phone_number": "246342176",
                "needs": "Grocery, Bills",
                "alergies": "Pollen, Hard-Work",
                "medications": "Cannabis"
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/clients', params: new_user, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('201')

    require 'pry'; binding.pry

  end
end