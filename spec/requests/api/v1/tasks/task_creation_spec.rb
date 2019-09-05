require 'rails_helper'

RSpec.describe 'Tasks API' do
  it 'can create a new task' do
    client = create(:client)
    list = List.create(name: 'list numero uno', client_id: "#{client.id}")
    task_params = {
      list_id: "#{list.id}",
      description: 'first task description',
      name: 'task uno',
      completed: 'false',
      due_date: Date.tomorrow
    }.to_json
    headers = { 'CONTENT_TYPE' => 'application/json'}

    post "/api/v1/clients/#{client.id}/lists/#{list.id}/tasks", params: task_params, headers: headers

    data = JSON.parse(response.body)
    task = Task.last

    expect(data['name']).to eq('task uno')
    expect(data['description']).to eq('first task description')
    expect(data['completed']).to eq(false)
    expect(data).to have_key('due_date')
    expect(task.list.client).to eq(client)
    expect(task.description).to eq('first task description')
    expect(task.name).to eq('task uno')
    expect(task.completed).to be false
  end

    it 'recieves a 404 if list_id is invalid' do
    client = create(:client)
    list = List.create(name: 'list numero uno', client_id: "#{client.id}")
    task_params = {
      list_id: "wrong_id",
      description: 'first task description',
      name: 'task uno',
      completed: 'false'
    }.to_json
    headers = { 'CONTENT_TYPE' => 'application/json'}

    post "/api/v1/clients/#{client.id}/lists/wrong_id/tasks", params: task_params, headers: headers

    data = JSON.parse(response.body)

    expect(status).to eq(404)
    expect(data['list']).to eq(['must exist'])
  end
end
