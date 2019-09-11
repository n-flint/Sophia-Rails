require 'rails_helper'

RSpec.describe 'Caretakers API' do
  before :each do
    @updated_caretaker = {
      'username': 'updated_caretaker_1',
      'name': 'updated_caretaker_uno',
      'email': 'updated_kate@email.com',
      'phone_number': 'updated_1234567891',
      'abilities': ['updated_ability_1']
    }

    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1',
      'role': 'caretaker'
    })

    @caretaker_2 = Caretaker.create({
      'username': 'caretaker_2',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_dos',
      'email': 'noah@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1',
      'role': 'caretaker'
    })



    @headers = { 'CONTENT_TYPE' => 'application/json'}

  end
  it 'can update a caretakers profile' do
    patch "/api/v1/caretakers/#{@caretaker_1.id}", params: @updated_caretaker.to_json, headers: @headers

    data = JSON.parse(response.body)

    expect(data['username']).to eq('updated_caretaker_1')
    expect(data['name']).to eq('updated_caretaker_uno')
    expect(data['email']).to eq('updated_kate@email.com')
    expect(data['phone_number']).to eq('updated_1234567891')
    expect(data['abilities']).to eq(['updated_ability_1'])
    expect(data['role']).to eq('caretaker')
  end

  it 'receives a 404 if the caretaker ID is invalid' do
    patch "/api/v1/caretakers/100", params: @updated_caretaker.to_json, headers: @headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Invalid ID')
  end

  it 'receives a 404 if the username provided is not unique' do
    invalid_caretaker = {
                "username": "#{@caretaker_2.username}"
      }.to_json

    patch "/api/v1/caretakers/#{@caretaker_1.id}", params: invalid_caretaker, headers: @headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Username Must Be Unique')
  end

  it 'receives a 404 if the email provided is not unique' do
    invalid_caretaker = {
                "email": "#{@caretaker_2.email}"
      }.to_json

    patch "/api/v1/caretakers/#{@caretaker_1.id}", params: invalid_caretaker, headers: @headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Email Must Be Unique')
  end
end
