require 'rails_helper'

RSpec.describe 'Clients API' do
  before :each do
    @new_client = {
                "username": "username1",
                "name": "name1",
                "street_address": "123 Fake St.",
                "city": "Denver",
                "state": "CO",
                "zip": "80203",
                "email": "new@email.com",
                "phone_number": "246342176",
                "needs": ["Grocery", "Bills"],
                "allergies": ["Pollen", "Hard-Work"],
                "medications": ["Cannabis"]
    }.to_json

    @current_client = Client.create({
                "username": "existing_user",
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
    })
  end
  it 'can create a new client profile' do
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/clients', params: @new_client, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('201')
    expect(data['username']).to eq('username1')
    expect(data['name']).to eq('name1')
    expect(data['street_address']).to eq('123 Fake St.')
    expect(data['city']).to eq('Denver')
    expect(data['state']).to eq('CO')
    expect(data['zip']).to eq('80203')
    expect(data['email']).to eq('new@email.com')
    expect(data['phone_number']).to eq('246342176')
    expect(data['needs']).to eq('Grocery, Bills')
    expect(data['allergies']).to eq('Pollen, Hard-Work')
    expect(data['medications']).to eq('Cannabis')
  end
  it 'recieves a 404 if username is not unique' do
    invalid_client = {
                "username": "#{@current_client.username}",
                "name": "name1",
                "street_address": "123 Fake St.",
                "city": "Denver",
                "state": "CO",
                "zip": "80203",
                "email": "example2@email.com",
                "phone_number": "246342176",
                "needs": ["Grocery", "Bills"],
                "allergies": ["Pollen", "Hard-Work"],
                "medications": ["Cannabis"]
    }.to_json
    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/clients', params: invalid_client, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('400')
    # require 'pry'; binding.pry
    expect(data['username']).to eq(['has already been taken'])
  end
  it 'recieves a 404 if email is not unique' do
    invalid_client = {
                "username": "name1",
                "name": "name1",
                "street_address": "123 Fake St.",
                "city": "Denver",
                "state": "CO",
                "zip": "80203",
                "email": "#{@current_client.email}",
                "phone_number": "246342176",
                "needs": ["Grocery", "Bills"],
                "allergies": ["Pollen", "Hard-Work"],
                "medications": ["Cannabis"]
    }.to_json
    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/clients', params: invalid_client, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('400')
    expect(data['email']).to eq(['has already been taken'])
  end
end
