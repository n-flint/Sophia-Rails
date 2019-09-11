require 'rails_helper'

RSpec.describe 'Caretakers API' do
  before :each do
    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno', 
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1'
    }),

    @caretaker_2 = Caretaker.create({
      'username': 'caretaker_2',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_dos', 
      'email': 'kate2@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_2'
    })
  end
  it 'can return a list of all the clientxs' do
    get '/api/v1/caretakers'

    data = JSON.parse(response.body)

    expect(data[0]['username']).to eq('caretaker_1') 
    expect(data[0]['name']).to eq('caretaker_uno') 
    expect(data[0]['email']).to eq('kate@email.com') 
    expect(data[0]['phone_number']).to eq('1234567891') 
    expect(data[0]['abilities']).to eq('ability_1') 
    expect(data[1]['username']).to eq('caretaker_2') 
    expect(data[1]['name']).to eq('caretaker_dos') 
    expect(data[1]['email']).to eq('kate2@email.com') 
    expect(data[1]['phone_number']).to eq('1234567891') 
    expect(data[1]['abilities']).to eq('ability_2') 
  end
end