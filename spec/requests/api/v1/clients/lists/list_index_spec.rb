require 'rails_helper'

RSpec.describe "List API index endpoint" do
  it "gets all lists associated with given client" do
    client = create(:client)
    list1 = create(:list, client: client)
    list2 = create(:list, client: client)
    list3 = create(:list, client: client)

    get "/api/v1/clients/#{client.id}/lists"

    expect(response).to be_successful


    lists = JSON.parse(response.body, symbolize_names: true)
    expect(lists.length).to eq(3)
    expect(lists.first).to have_key(:name)
    expect(lists.first).to have_key(:client_id)
    expect(lists.first).to have_key(:caretaker_id)
    expect(lists.first).to have_key(:created_at)
    expect(lists.first).to have_key(:updated_at)
  end

  it "returns 404 if client does not exist" do
    get "/api/v1/clients/7873/lists"

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
