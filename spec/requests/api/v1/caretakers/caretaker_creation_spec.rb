require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can create a new caretaker profile' do
    new_caretaker = {
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno', 
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': ['ablity_1', 'ability_2']
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/caretakers', params: new_caretaker, headers: headers

    data = JSON.parse(response.body)
    require 'pry'; binding.pry
  end
end