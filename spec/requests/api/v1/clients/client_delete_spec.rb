require 'rails_helper'

RSpec.describe 'Clients API' do
  before :each do
    @client = create(:client)
  end
  it 'can delete a client portfolio' do
    headers = { 'CONTENT_TYPE' => 'application/json'}
    delete "/api/v1/clients/#{@client.id}", headers: headers

    expect(status).to eq(204)

    expect(Client.all.count).to eq(0)
  end

  it 'receives a 404 if id provided is not valid' do
    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/clients/abc", headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Invalid ID')
  end
end
