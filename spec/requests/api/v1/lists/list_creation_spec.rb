require 'rails_helper'

RSpec.describe 'List API' do
  it 'can create a list' do
    client = create(:client)

    list_params = {
      :name => 'Groceries'
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post "/api/v1/clients/#{client.id}/lists", params: list_params, headers: headers

    new_list = JSON.parse(response.body)

    expect(response).to be_successful
    expect(status).to eq(201)
    expect(List.last.name).to eq('Groceries')
    expect(new_list).to have_key('id')
    expect(new_list['name']).to eq('Groceries')
    expect(new_list['client_id']).to eq(client.id)
  end

  it 'recieves a 404 if client_id is invalid' do
    list_params = {
      :name => 'Groceries'
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post "/api/v1/clients/abc/lists", params: list_params, headers: headers

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['client']).to eq(['must exist'])
  end
end
