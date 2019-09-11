require 'rails_helper'

RSpec.describe 'List API' do
  it 'client can create a list' do
    client = create(:client)
    caretaker = create(:caretaker)

    list_params = {
      :name => 'Groceries',
      :caretaker_id => caretaker.id,
      :client_id => client.id
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
    expect(new_list['caretaker_id']).to eq(caretaker.id)
  end

  it 'recieves a 404 if client_id is invalid' do
    list_params = {
      :name => 'Groceries',
      :caretaker_id => 1
    }.to_json

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post "/api/v1/clients/abc/lists", params: list_params, headers: headers

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['client']).to eq(['must exist'])
  end
end
