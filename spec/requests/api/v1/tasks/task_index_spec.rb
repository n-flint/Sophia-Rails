require 'rails_helper'

RSpec.describe "Task API index endpoint" do
  it "gets all tasks associated with a client's list" do
    client = create(:client)
    list = create(:list, client: client)
    tastk1 = create(:task, list: list)
    tastk2 = create(:task, list: list)
    tastk3 = create(:task, list: list)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    get "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks", headers: headers

    expect(response).to be_successful
    expect(status).to eq(200)

    tasks = JSON.parse(response.body, symbolize_names: true)

    expect(tasks).to be_a Array
    expect(tasks.length).to eq(3)
    expect(tasks.first).to have_key(:name)
    expect(tasks.first).to have_key(:description)
    expect(tasks.first).to have_key(:completed)
    expect(tasks.first).to have_key(:due_date)
    expect(tasks.first).to have_key(:list_id)
    expect(tasks.first).to have_key(:created_at)
    expect(tasks.first).to have_key(:updated_at)
  end

  it "returns 404 if client id is invalid" do
    client = create(:client)
    list = create(:list, client: client)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    get "/api/v1/clients/invalid_id/lists/#{list.id}/tasks", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if list id is invalid" do
    client = create(:client)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    get "/api/v1/clients/#{client.id}/lists/invalid_id/tasks", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
