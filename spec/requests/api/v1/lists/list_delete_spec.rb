require 'rails_helper'

RSpec.describe 'Lists Delete API' do
  it "can delete a list" do
    list = create(:list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    delete "/api/v1/lists/#{list.id}", headers: headers

    expect(status).to eq(204)

    expect(List.all.count).to eq(0)
  end

  it "gives 404 with invalid list id" do
    list = create(:list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    delete "/api/v1/lists/invalid_id", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("List Not Found")
  end
end
