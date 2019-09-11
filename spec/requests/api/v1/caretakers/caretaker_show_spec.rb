require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can get a single caretaker' do
    caretaker = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1',
      'role': 'caretaker'
    })

    get "/api/v1/caretakers/#{caretaker.id}"

    data = JSON.parse(response.body)

    expect(response.code).to eq('200')
    expect(data['username']).to eq('caretaker_1')
    expect(data['name']).to eq('caretaker_uno')
    expect(data['email']).to eq('kate@email.com')
    expect(data['phone_number']).to eq('1234567891')
    expect(data['abilities']).to eq('ability_1')
    expect(data['role']).to eq('caretaker')
  end

  it 'returns a 404 if a invalid ID is provided' do
    get '/api/v1/caretakers/invalid_id'

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['message']).to eq('Invalid ID')
  end
end
