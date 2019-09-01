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
                "allergies": "Pollen, Hard-Work",
                "medications": "Cannabis"
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/clients', params: new_user, headers: headers

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.code).to eq('201')
    expect(data[:username]).to eq('username1')
    expect(data[:name]).to eq('name1')
    expect(data[:street_address]).to eq('123 Fake St.')
    expect(data[:city]).to eq('Denver')
    expect(data[:state]).to eq('CO')
    expect(data[:zip]).to eq('80203')
    expect(data[:email]).to eq('example@email.com')
    expect(data[:phone_number]).to eq('246342176')
    expect(data[:needs]).to eq('Grocery, Bills')
    expect(data[:allergies]).to eq('Pollen, Hard-Work')
    expect(data[:medications]).to eq('Cannabis')
  end
end