require 'rails_helper'

RSpec.describe 'Clients API' do
  before :each do
    @client1 = create(:client)
    @client2 = create(:client)
  end

  it 'can update a client portfolio' do
    updated_client = {
      username: "updated_user",
      name: "name2",
      password: "password",
      password_confirmation: "password",
      street_address: "123 New St.",
      city: "UpdatedDenver",
      state: "CO",
      zip: "updated80203",
      email: "Updatedexample@email.com",
      phone_number: "new246342176",
      needs: ["Updated", "Grocery", "Bills"],
      allergies: ["Updated", "Pollen", "Hard-Work"],
      medications: ["Updated", "Cannabis"],
      diet_restrictions: ["Updated", "Cannabis"]
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/clients/#{@client1.id}", params: updated_client, headers: headers

    expect(response).to be_successful
    expect(status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)
    updated_client = Client.find(data[:id])

    expect(data[:username]).to eq('updated_user')
    expect(data[:name]).to eq('name2')
    expect(data[:street_address]).to eq('123 New St.')
    expect(data[:city]).to eq('UpdatedDenver')
    expect(data[:state]).to eq('CO')
    expect(data[:zip]).to eq('updated80203')
    expect(data[:role]).to eq('client')
    expect(data[:needs]).to eq(['Updated', 'Grocery', 'Bills'])
    expect(data[:allergies]).to eq(['Updated', 'Pollen', 'Hard-Work'])
    expect(data[:medications]).to eq(['Updated', 'Cannabis'])
    expect(data[:diet_restrictions]).to eq(['Updated', 'Cannabis'])

    expect(updated_client.username).to eq('updated_user')
    expect(updated_client.diet_restrictions).to eq('Updated, Cannabis')
  end

  it 'receives a 404 if updated username is not unique' do
    updated_client = {
      username: @client2.username
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/clients/#{@client1.id}", params: updated_client, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Username Must Be Unique')
  end

  it 'receives a 404 if updated email is not unique' do
    updated_client = {
      email: @client2.email
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/clients/#{@client1.id}", params: updated_client, headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Email Must Be Unique')
  end
end
