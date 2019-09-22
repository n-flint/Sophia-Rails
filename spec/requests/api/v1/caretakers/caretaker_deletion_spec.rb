require 'rails_helper'

RSpec.describe 'Caretakers API' do
  it 'can delete a caretakers profile' do
    caretaker = create(:caretaker)

    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/caretakers/#{caretaker.id}", headers: headers

    expect(status).to eq(204)
    expect(Caretaker.all).to eq([])
  end

  it 'receives a 404 if ID provided is not valid' do
    headers = { 'CONTENT_TYPE' => 'application/json'}

    delete "/api/v1/caretakers/abc", headers: headers

    data = JSON.parse(response.body)

    expect(response.code).to eq('404')
    expect(data['message']).to eq('Invalid ID')
  end
end
