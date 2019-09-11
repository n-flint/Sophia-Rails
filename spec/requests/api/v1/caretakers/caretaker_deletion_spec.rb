require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can delete a caretakers profile' do
    @current_caretaker_1 = Caretaker.create({
                "username": "existing_user_1",
                "password": "password",
                "name": "name1",
                "email": "example@email.com",
                "phone_number": "246342176",
    })

    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/caretakers/#{@current_caretaker_1.id}", headers: headers

    expect(status).to eq(204)
    expect(Caretaker.all).to eq([])
  end

  it 'receives a 404 if ID provided is not valid' do
    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/caretakers/abc", headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Invalid ID')
  end
end