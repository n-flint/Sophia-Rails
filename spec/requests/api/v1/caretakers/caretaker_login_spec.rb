require 'rails_helper'

RSpec.describe "Caretaker API Login" do
  it "can give caretaker object with name and password" do
    caretaker = create(:caretaker, password: 'pass')

    body = {
      username: caretaker.username,
      password: 'pass'
    }

    headers = {
      content_type: 'application/json',
      accept: 'application/json'
    }

    post "/api/v1/login", body: body, headers: header

    expect(response).to be_successful
    expect(status).to eq(200)

    found_caretaker = JSON.parse(response.body, symbolize_names: true)

    expect(found_caretaker[:username]).to eq(caretaker.username)

    expect(found_caretaker).to have_key(:id)
    expect(found_caretaker).to have_key(:name)
    expect(found_caretaker).to have_key(:email)
    expect(found_caretaker).to have_key(:phone_number)
    expect(found_caretaker).to have_key(:abilities)
    expect(found_caretaker).to have_key(:role)
  end
end
