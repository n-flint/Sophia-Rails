require 'rails_helper'

RSpec.describe 'Caretakers API' do
  before :each do
    @new_caretaker = {
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1',
      'role': 'caretaker'
    }

    @taken_username = {
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'new_email@email.com',
      'phone_number': '1234567891'
    }.to_json

    @taken_email = {
      'username': 'caretaker_2',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891'
    }.to_json

    @headers = { 'CONTENT_TYPE' => 'application/json'}

  end
  it 'can create a new caretaker profile' do
    post '/api/v1/caretakers', params: @new_caretaker.to_json, headers: @headers

    data = JSON.parse(response.body)

    expect(data['username']).to eq('caretaker_1')
    expect(data['name']).to eq('caretaker_uno')
    expect(data['email']).to eq('kate@email.com')
    expect(data['phone_number']).to eq('1234567891')
    expect(data['abilities']).to eq('ability_1')
    expect(data['role']).to eq('caretaker')
  end

  it 'recieves a 400 if username is not unique' do
    Caretaker.create(@new_caretaker)

    post '/api/v1/caretakers', params: @taken_username, headers: @headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('400')
    expect(data['username']).to eq(['has already been taken'])
  end

  it 'recieves a 400 if email is not unique' do
    Caretaker.create(@new_caretaker)

    post '/api/v1/caretakers', params: @taken_email, headers: @headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('400')
    expect(data['email']).to eq(['has already been taken'])
  end
end
