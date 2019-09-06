require 'rails_helper'

RSpec.describe 'List API' do
  before :each do
    @client = create(:client)
    @list = create(:list, client_id: @client.id)
  end

  it 'can delete a list' do
    delete "/api/v1/clients/#{@client.id}/lists/#{@list.id}"

    expect(status).to eq(204)
    expect(@client.lists).to eq([])
  end

  it 'returns a 404 if list ID is invalid' do
    delete "/api/v1/clients/#{@client.id}/lists/invalid_id"

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['message']).to eq('Invalid ID')
  end
end