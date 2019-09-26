require 'rails_helper'

RSpec.describe 'Tasks Update API' do
  it "can update a tasks name" do
    list = create(:list)
    task = create(:task, list: list)

    body = {
      name: 'New Task Name'
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    patch "/api/v1/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    task_data = JSON.parse(response.body, symbolize_names: true)

    expect(task_data[:name]).to eq('New Task Name')
    expect(task_data).to have_key(:description)
    expect(task_data).to have_key(:completed)
    expect(task_data).to have_key(:list_id)
    expect(task_data).to have_key(:due_date)
    expect(task_data).to have_key(:priority)
    expect(task_data).to have_key(:created_at)
    expect(task_data).to have_key(:updated_at)

    task.reload

    expect(task.name).to eq(body[:name])
  end

  it "can update a tasks completed status" do
    list = create(:list)
    task = create(:task, list: list)

    body = {
      completed: true
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    patch "/api/v1/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    task.reload

    expect(task.completed).to be true
  end

  it "can update a tasks due date" do
    list = create(:list)
    task = create(:task, list: list)

    body = {
      due_date: '2021-12-25'
    }

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    patch "/api/v1/lists/#{list.id}/tasks/#{task.id}", headers: headers, params: body

    expect(response).to be_successful
    expect(status).to eq(200)

    task.reload

    expect(task.due_date).to eq(body[:due_date].to_datetime)
  end
end
