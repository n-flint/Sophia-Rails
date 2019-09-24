require 'rails_helper'

RSpec.describe 'Lists Read API' do
  it "can get all client lists" do
    client = create(:client)
    list1 = create(:list, client: client)
    list2 = create(:list, client: client)
    list3 = create(:list, client: client)

    body = {
      client_id: client.id
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    get "/api/v1/lists", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    lists = JSON.parse(response.body, symbolize_names: true)

    expect(lists).to be_a Array
    expect(lists.length).to eq(3)
    expect(lists.first).to have_key(:name)
    expect(lists.first).to have_key(:client_id)
    expect(lists.first).to have_key(:caretaker_id)
    expect(lists.first).to have_key(:created_at)
    expect(lists.first).to have_key(:updated_at)
  end

  it "can get all caretaker lists" do
    caretaker = create(:caretaker)
    list1 = create(:list, caretaker: caretaker)
    list2 = create(:list, caretaker: caretaker)
    list3 = create(:list, caretaker: caretaker)

    body = {
      caretaker_id: caretaker.id
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    get "/api/v1/lists", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    lists = JSON.parse(response.body, symbolize_names: true)

    expect(lists).to be_a Array
    expect(lists.length).to eq(3)
    expect(lists.first).to have_key(:name)
    expect(lists.first).to have_key(:client_id)
    expect(lists.first).to have_key(:caretaker_id)
    expect(lists.first).to have_key(:created_at)
    expect(lists.first).to have_key(:updated_at)
  end

  it "can show a list" do
    list = create(:list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    get "/api/v1/lists/#{list.id}", headers: headers

    expect(response).to be_successful
    expect(status).to eq(200)

    list_data = JSON.parse(response.body, symbolize_names: true)

    expect(list_data[:name]).to eq(list.name)
    expect(list_data[:client_id]).to eq(list.client_id)
    expect(list_data[:caretaker_id]).to eq(list.caretaker_id)
    expect(list_data).to have_key(:created_at)
    expect(list_data).to have_key(:updated_at)
  end
end
