require 'rails_helper'

RSpec.describe "Client API Login" do
  it "can give client id with name and password" do
    client = create(:client, password: 'pass')

    headers = {
      content_type: 'application/json',
      accept: 'application/json'
    }

    body = {
      username: client.username,
      password: 'pass'
    }

    post '/api/v1/login', headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    found_client = JSON.parse(response.body, symbolize_names: true)

    expect(found_client[:username]).to eq(client.username)
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
    expect(found_client).to have_key(:diet_restrictions)
    expect(found_client).to have_key(:created_at)
    expect(found_client).to have_key(:updated_at)
    expect(found_client).to have_key(:role)
  end

  it "can give correct error if password is incorrect" do
    client = create(:client, password: 'pass')

    headers = {
      content_type: 'application/json',
      accept: 'application/json'
    }

    body = {
      username: client.username,
      password: 'not_pass'
    }

    post '/api/v1/login', headers: headers, params: body

    expect(status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Incorrect Username/Password Combination")
  end

  it "can give correct error if username is incorrect" do
    client = create(:client, password: 'pass')

    headers = {
      content_type: 'application/json',
      accept: 'application/json'
    }

    body = {
      username: 'no_user',
      password: 'pass'
    }

    post '/api/v1/login', headers: headers, params: body

    expect(status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Incorrect Username/Password Combination")
  end
end
