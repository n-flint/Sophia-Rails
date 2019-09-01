require 'rails_helper'

RSpec.describe "Client Profile Endpoint" do
  it "can give client profile info" do
    client = create(:client)

    get "/api/v1/clients/#{client.id}"

    expect(response).to be_successful
  end
end
