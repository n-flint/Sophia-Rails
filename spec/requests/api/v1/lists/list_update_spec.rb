require 'rails_helper'

RSpec.describe 'Lists Update API' do
  it "can update a lists name" do
    list = create(:list)

    body = {
      name: 'New Name'
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    patch "/api/v1/lists/#{list.id}", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_list_data = JSON.parse(response.body, symbolize_names: true)
    list.reload

    expect(updated_list_data[:name]).to eq(list.name)

    expect(updated_list_data[:name]).to eq(body[:name])
    expect(updated_list_data[:client_id]).to eq(list.client.id)
    expect(updated_list_data[:caretaker_id]).to eq(list.caretaker.id)
    expect(updated_list_data).to have_key(:created_at)
    expect(updated_list_data).to have_key(:updated_at)
  end

  it "cant update with invalid list id" do
    list = create(:list)

    body = {
      name: 'New Name'
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    patch "/api/v1/lists/invalid_id", headers: headers, params: body

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)
    list.reload

    expect(body[:name]).to_not eq(list.name)

    expect(error[:message]).to eq('List Not Found')
  end
end
