require 'rails_helper'

RSpec.describe 'Clients API' do
  before :each do
    @current_client_1 = Client.create({
                "username": "existing_user_1",
                "password": "password",
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
  it 'can delete a client portfolio' do
    headers = { 'CONTENT_TYPE' => 'application/json'}
    delete "/api/v1/clients/#{@current_client_1.id}", params: @updated_client, headers: headers

    expect(status).to eq(204)

    expect(Client.all.count).to eq(0)
  end
  it 'receives a 404 if id provided is not valid' do
    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/clients/abc", headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Invalid ID')
  end
end
