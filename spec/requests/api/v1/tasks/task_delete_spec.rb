require 'rails_helper'

RSpec.describe 'Tasks Delete API' do
  it "can delete a task" do
    list = create(:list)
    task = create(:task, list: list)

    headers = {
      content_type: "application/json",
      accept: "application/json"
    }

    delete "/api/v1/lists/#{list.id}/tasks/#{task.id}"

    expect(response).to be_successful
    expect(status).to eq(204)

    expect(Task.all.count).to eq(0)
  end
end
