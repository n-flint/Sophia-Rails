require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can update a caretakers profile' do
    updated_caretaker = {
      'username': 'updated_caretaker_1',
      'name': 'updated_caretaker_uno', 
      'email': 'updated_kate@email.com',
      'phone_number': 'updated_1234567891',
      'abilities': 'updated_ability_1'
    }
    
    caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno', 
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1'
    })

    caretaker_2 = Caretaker.create({
      'username': 'caretaker_2',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_dos', 
      'email': 'noah@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1'
    })

    @headers = { 'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/caretakers/#{caretaker_1.id}", params: updated_caretaker.to_json, headers: @headers

    data = JSON.parse(response.body)

    expect(data['username']).to eq('updated_caretaker_1')
    expect(data['name']).to eq('updated_caretaker_uno')
    expect(data['email']).to eq('updated_kate@email.com')
    expect(data['phone_number']).to eq('updated_1234567891')
    expect(data['abilities']).to eq('updated_ability_1')
  end
end