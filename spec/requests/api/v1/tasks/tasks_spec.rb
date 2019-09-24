require 'rails_helper'

RSpec.describe 'Tasks API' do
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
    expect(tasks.first).to have_key(:created_at)
    expect(tasks.first).to have_key(:updated_at)
    expect(tasks.first[:completed]).to be false
    expect(tasks.first[:list_id]).to eq(list.id)
  end
end
