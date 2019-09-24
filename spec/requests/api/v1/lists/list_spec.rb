require 'rails_helper'

RSpec.describe 'lists API' do

  context 'clients' do
    it "can get all lists" do
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
  end

  context 'caretakers' do
    it "can get all lists" do
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
  end
end
