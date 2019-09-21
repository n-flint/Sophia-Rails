require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can get a single caretaker' do
    caretaker = create(:caretaker)

    get "/api/v1/caretakers/#{caretaker.id}"

    expect(response).to be_successful
    expect(status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:username]).to eq(caretaker.username)
    expect(data[:name]).to eq(caretaker.name)
    expect(data[:email]).to eq(caretaker.email)
    expect(data[:phone_number]).to eq(caretaker.phone_number)
    expect(data).to have_key(:abilities)
    expect(data[:abilities]).to be_a Array
    expect(data[:abilities].length).to eq(2)
    expect(data[:role]).to eq(caretaker.role)
  end

  it 'returns a 404 if a invalid ID is provided' do
    get '/api/v1/caretakers/invalid_id'

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['message']).to eq('Invalid ID')
  end
end
