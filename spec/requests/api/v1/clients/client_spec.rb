require 'rails_helper'

RSpec.describe "Client API" do
  it "can give client profile info" do
    client = create(:client)

    get "/api/v1/clients/#{client.id}"

    expect(response).to be_successful

    found_client = JSON.parse(response.body, symbolize_names: true)

    expect(found_client).to have_key(:username)
    expect(found_client).to have_key(:id)
    expect(found_client).to have_key(:name)
    expect(found_client).to have_key(:street_address)
    expect(found_client).to have_key(:city)
    expect(found_client).to have_key(:state)
    expect(found_client).to have_key(:zip)
    expect(found_client).to have_key(:email)
    expect(found_client).to have_key(:phone_number)
    expect(found_client).to have_key(:needs)
    expect(found_client).to have_key(:allergies)
    expect(found_client).to have_key(:medications)
    expect(found_client).to have_key(:role)
    expect(found_client).to have_key(:diet_restrictions)
    expect(found_client).to have_key(:created_at)
    expect(found_client).to have_key(:updated_at)
    expect(found_client[:needs]).to be_a Array
    expect(found_client[:medications]).to be_a Array
    expect(found_client[:allergies]).to be_a Array
  end

  it "returns 404 with non existing id" do
    get "/api/v1/clients/342"

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq('Not Found')
  end
end
