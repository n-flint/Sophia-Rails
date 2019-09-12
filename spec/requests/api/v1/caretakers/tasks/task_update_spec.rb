require 'rails_helper'

RSpec.describe "Caretaker Task API update endpoint" do
  before :each do
    @caretaker_1 = Caretaker.create({
      'username': 'caretaker_1',
      'password': 'password',
      'password_confirmation': 'password',
      'name': 'caretaker_uno',
      'email': 'kate@email.com',
      'phone_number': '1234567891',
      'abilities': 'ability_1, ability_2',
      'role': 'caretaker'
    })
    @client = create(:client)
    @list_1 = create(:list, client: @client, caretaker_id: @caretaker_1.id)
    @task_1 = create(:task, list: @list_1)
    @headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }
  end

  it "updates a tasks name on a caretakers list" do
    updated_task_data = {
      name: "updated name"
    }

    patch "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list_1.id}/tasks/#{@task_1.id}", headers: @headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(@task_1.id)

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

  it "updates a tasks description on a caretakers list" do
    updated_task_data = {
      description: "updated description"
    }

    patch "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list_1.id}/tasks/#{@task_1.id}", headers: @headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(@task_1.id)

    expect(updated_task_data[:description]).to eq("updated description")
    expect(updated_task.description).to eq("updated description")
  end

  it "updates a tasks completion on a caretakers list" do
    updated_task_data = {
      completed: true
    }

    expect(@task_1.completed).to be false

    patch "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list_1.id}/tasks/#{@task_1.id}", headers: @headers, params: updated_task_data

    expect(response).to be_successful
    expect(status).to eq(200)

    updated_task_data = JSON.parse(response.body, symbolize_names: true)
    updated_task = Task.find(@task_1.id)

    expect(updated_task_data[:completed]).to be true
    expect(updated_task.completed).to be true
  end

  it "returns 404 if invalid client id is given" do
    updated_task_data = {
      name: 'updated_name'
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/caretakers/invalid_id/lists/#{@list_1.id}/tasks/#{@task_1.id}", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid list id is given" do
    updated_task_data = {
      name: 'updated_name'
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/caretakers/#{@caretaker_1.id}/lists/invalid_id/tasks/#{@task_1.id}", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end

  it "returns 404 if invalid task id is given" do
    updated_task_data = {
      name: 'updated_name'
    }

    headers = {
      accept: 'application/json',
      content_type: 'application/json'
    }

    patch "/api/v1/caretakers/#{@caretaker_1.id}/lists/#{@list_1.id}/tasks/invalid_id", headers: headers, params: updated_task_data

    expect(status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:message]).to eq("Not Found")
  end
end
