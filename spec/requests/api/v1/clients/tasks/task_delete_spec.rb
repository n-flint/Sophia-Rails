require 'rails_helper'

RSpec.describe "Task API delete endpoint" do
  it "deletes a task" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    delete "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/#{task.id}", headers: headers

    expect(response).to be_successful
    expect(status).to eq(204)

    expect(list.tasks.count).to eq(0)
  end

  it "returns 404 if invalid client id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    delete "/api/v1/clients/invalid_id/lists/#{list.id}/tasks/#{task.id}", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid list id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    delete "/api/v1/clients/#{client.id}/lists/invalid_id/tasks/#{task.id}", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid task id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    delete "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/invalid_id", headers: headers

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
