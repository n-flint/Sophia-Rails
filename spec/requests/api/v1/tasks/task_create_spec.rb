require 'rails_helper'

RSpec.describe 'Tasks Create API' do
  it "can create a task" do
    list = create(:list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    body = {
      name: 'Mow Back Yard',
      description: 'make sure to weedeat',
      list_id: list.id,
      due_date: '2019-12-28',
      priority: 'low'
    }

    post "/api/v1/lists/#{list.id}/tasks", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    task_data = JSON.parse(response.body, symbolize_names: true)

    expect(task_data[:name]).to eq(body[:name])
    expect(task_data[:priority]).to eq(body[:priority])
    expect(task_data[:description]).to eq(body[:description])
    expect(task_data[:completed]).to be false
    expect(task_data[:list_id]).to eq(list.id)
    expect(task_data).to have_key(:due_date)
    expect(task_data).to have_key(:created_at)
    expect(task_data).to have_key(:updated_at)

    new_task = Task.last

    expect(new_task.name).to eq(task_data[:name])
  end

  it "cant create a task without a list" do
    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    body = {
      name: 'Mow Back Yard',
      description: 'make sure to weedeat',
      due_date: '2019-12-28'
    }

    post "/api/v1/lists/invalid_id/tasks", headers: headers, params: body

    expect(status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:list]).to eq(['must exist'])
  end

  it "can create a task without a due date" do
    list = create(:list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    body = {
      name: 'Mow Back Yard',
      description: 'make sure to weedeat',
      list_id: list.id,
    }

    post "/api/v1/lists/#{list.id}/tasks", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    task_data = JSON.parse(response.body, symbolize_names: true)

    expect(task_data[:name]).to eq(body[:name])
    expect(task_data[:priority]).to eq('medium')
    expect(task_data[:description]).to eq(body[:description])
    expect(task_data[:completed]).to be false
    expect(task_data[:list_id]).to eq(list.id)
    expect(task_data).to_not have_key(:due_date)
    expect(task_data).to have_key(:created_at)
    expect(task_data).to have_key(:updated_at)
  end
end
