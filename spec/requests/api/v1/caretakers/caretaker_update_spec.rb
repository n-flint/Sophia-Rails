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

    @caretaker1 = create(:caretaker)
    @caretaker2 = create(:caretaker)

    @headers = { 'CONTENT_TYPE' => 'application/json'}
  end

  it 'can update a caretakers profile' do
    patch "/api/v1/caretakers/#{@caretaker1.id}", params: @updated_caretaker.to_json, headers: @headers

    data = JSON.parse(response.body, symbolize_names: true)
    updated_caretaker = Caretaker.find(@caretaker1.id)

    expect(updated_caretaker.username).to eq(@updated_caretaker[:username])
    expect(updated_caretaker.name).to eq(@updated_caretaker[:name])
    expect(updated_caretaker.email).to eq(@updated_caretaker[:email])

    expect(data[:username]).to eq(updated_caretaker.username)
    expect(data).to have_key(:name)
    expect(data).to have_key(:email)
    expect(data).to have_key(:phone_number)
    expect(data).to have_key(:role)
    expect(data).to have_key(:abilities)
    expect(data[:abilities]).to be_a Array
    expect(data[:abilities].length).to eq(1)
  end

  it 'receives a 404 if the caretaker ID is invalid' do
    patch "/api/v1/caretakers/100", params: @updated_caretaker.to_json, headers: @headers

    expect(status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)


    expect(data[:message]).to eq('Invalid ID')
  end

  it 'receives a 404 if the username provided is not unique' do
    invalid_caretaker = {
                "username": "#{@caretaker2.username}"
      }.to_json

    patch "/api/v1/caretakers/#{@caretaker1.id}", params: invalid_caretaker, headers: @headers

    expect(status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:message]).to eq('Username Must Be Unique')
  end

  it 'receives a 404 if the email provided is not unique' do
    invalid_caretaker = {
                "email": "#{@caretaker2.email}"
      }.to_json

    patch "/api/v1/caretakers/#{@caretaker1.id}", params: invalid_caretaker, headers: @headers

    expect(status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:message]).to eq('Email Must Be Unique')
  end
end
