require 'rails_helper'

RSpec.describe "Caretaker Tasks API index endpoint" do
  before :each do
    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno', 
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1'
    })
    @client = create(:client)
    @list = create(:list, client: @client, caretaker_id: @caretaker_1.id)
    @tastk1 = create(:task, list: @list)
    @tastk2 = create(:task, list: @list)
    @tastk3 = create(:task, list: @list)

    @headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

  end
  it "gets all tasks associated with a caretakers's list" do
    get "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list.id}/tasks", headers: @headers

    expect(response).to be_successful
    expect(status).to eq(200)

    tasks = JSON.parse(response.body, symbolize_names: true)

    expect(tasks).to be_a Array
    expect(tasks.length).to eq(3)
    expect(tasks.first).to have_key(:name)
    expect(tasks.first).to have_key(:description)
    expect(tasks.first).to have_key(:completed)
    expect(tasks.first).to have_key(:due_date)
    expect(tasks.first[:due_date]).to eq(Date.tomorrow.strftime("%m/%d"))
    expect(tasks.first).to have_key(:list_id)
    expect(tasks.first).to have_key(:created_at)
    expect(tasks.first).to have_key(:updated_at)
  end

  it "returns 404 if caretaker id is invalid" do
    get "/api/v1/clients/invalid_id/lists/#{@list.id}/tasks", headers: @headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if list id is invalid" do
    get "/api/v1/clients/#{@client.id}/lists/invalid_id/tasks", headers: @headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
