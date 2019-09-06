require 'rails_helper'


RSpec.describe "List API update endpoint" do
  it "updates a clients list" do
    client = create(:client)
    list = create(:list, client: client)

    update_data = {
      name: "updated name"
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}", headers: headers, params: update_data

    expect(response).to be_successful

    updated_list_data = JSON.parse(response.body, symbolize_names: true)
    updated_list = List.find(list.id)

    expect(updated_list_data[:name]).to eq("updated name")
    expect(updated_list.name).to eq("updated name")
  end

  it "returns 404 with invalid client id" do
    client = create(:client)
    list = create(:list, client: client)

    update_data = {
      name: "updated name"
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/clients/20302/lists/#{list.id}", headers: headers, params: update_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 with invalid list id" do
    client = create(:client)

    update_data = {
      name: "updated name"
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/clients/#{client.id}/lists/303040", headers: headers, params: update_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
