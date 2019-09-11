require 'rails_helper'

RSpec.describe "List API show endpoint" do
  before :each do
    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1, ability_2',
      'role': 'caretaker'
    })
    @client = create(:client)
    @list1 = create(:list, client: @client, caretaker_id: @caretaker_1.id)
    @list2 = create(:list, client: @client, caretaker_id: @caretaker_1.id)

  end
  it "gets a single list associated with given caretaker" do
    get "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list1.id}"

    list = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(list).to have_key(:name)
    expect(list).to have_key(:client_id)
    expect(list).to have_key(:caretaker_id)
    expect(list).to have_key(:created_at)
    expect(list).to have_key(:updated_at)
  end

  it "returns 404 if client does not exist" do
    get "/api/v1/caretakers/invalid_id/lists/#{@list1.id}"

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if list does not exist" do
    get "/api/v1/caretakers/#{@caretaker_1.id}/lists/invalid_id"

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
