require 'rails_helper'

RSpec.describe 'Tasks Read API' do
  it "gets all tasks" do
    list = create(:list)
    task1 = create(:task, list: list)
    task2 = create(:task, list: list)
    task3 = create(:task, list: list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    get "/api/v1/lists/#{list.id}/tasks", headers: headers

    expect(response).to be_successful
    expect(status).to eq(200)

    tasks = JSON.parse(response.body, symbolize_names: true)

    expect(tasks).to be_a Array
    expect(tasks.length).to eq(3)
    expect(tasks.first).to have_key(:name)
    expect(tasks.first).to have_key(:description)
    expect(tasks.first).to have_key(:due_date)
    expect(tasks.first).to have_key(:priority)
    expect(tasks.first).to have_key(:created_at)
    expect(tasks.first).to have_key(:updated_at)
    expect(tasks.first[:completed]).to be false
    expect(tasks.first[:list_id]).to eq(list.id)
  end

  it "gets one task" do
    list = create(:list)
    task = create(:task, list: list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    get "/api/v1/lists/#{list.id}/tasks/#{task.id}", headers: headers

    expect(response).to be_successful
    expect(status).to eq(200)

    task_data = JSON.parse(response.body, symbolize_names: true)

    expect(task_data[:name]).to eq(task.name)
    expect(task_data[:description]).to eq(task.description)
    expect(task_data[:completed]).to eq(task.completed)
    expect(task_data[:list_id]).to eq(task.list_id)

    expect(task_data).to have_key(:due_date)
    expect(task_data).to have_key(:priority)
    expect(task_data).to have_key(:created_at)
    expect(task_data).to have_key(:updated_at)
  end
end
