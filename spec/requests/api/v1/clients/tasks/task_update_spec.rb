require 'rails_helper'

RSpec.describe "Task API update endpoint" do
  it "updates a tasks name on a clients list" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    updated_task_data = {
      name: "updated name"
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(task.id)

    expect(updated_task_data[:name]).to eq("updated name")
    expect(updated_task_data).to have_key(:description)
    expect(updated_task_data).to have_key(:completed)
    expect(updated_task_data).to have_key(:due_date)
    expect(updated_task_data[:due_date]).to eq(Date.tomorrow.strftime("%m/%d"))
    expect(updated_task_data).to have_key(:list_id)
    expect(updated_task_data).to have_key(:created_at)
    expect(updated_task_data).to have_key(:updated_at)
    expect(updated_task.name).to eq("updated name")
  end

  it "updates a tasks description on a clients list" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    updated_task_data = {
      description: "updated description"
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(task.id)

    expect(updated_task_data[:description]).to eq("updated description")
    expect(updated_task.description).to eq("updated description")
  end

  it "updates a tasks completion on a clients list" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    updated_task_data = {
      completed: true
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    expect(task.completed).to be false

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(task.id)

    expect(updated_task_data[:completed]).to be true
    expect(updated_task.completed).to be true
  end

  # this fails everyonce and a while do to something with the date.
  # the task does get updated though
  it "updates a tasks due date on a clients list" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    new_date = Time.now + 1.day

    updated_task_data = {
      due_date: new_date
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    expect(task.completed).to be false

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(task.id)

    expect(updated_task.due_date.day).to eq(new_date.day)
  end

  it "returns 404 if invalid client id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    new_date = Time.now + 10.hours

    updated_task_data = {
      due_date: new_date
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    expect(task.completed).to be false

    patch "/api/v1/clients/invalid_id/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid list id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    new_date = Time.now + 10.hours

    updated_task_data = {
      due_date: new_date
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    expect(task.completed).to be false

    patch "/api/v1/clients/#{client.id}/lists/invalid_id/tasks/#{task.id}", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid task id is given" do
    client = create(:client)
    list = create(:list, client: client)
    task = create(:task, list: list)

    new_date = Time.now + 10.hours

    updated_task_data = {
      due_date: new_date
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    expect(task.completed).to be false

    patch "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks/invalid_id", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
