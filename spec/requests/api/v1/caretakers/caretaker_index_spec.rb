require 'rails_helper'

RSpec.describe 'Caretakers API' do
  before :each do
    @caretaker1 = create(:caretaker)
    @caretaker2 = create(:caretaker)
  end
  it 'can return a list of all the caretakers' do
    get '/api/v1/caretakers'

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_a Array
    expect(data.count).to eq(2)

    expect(data.first).to have_key(:username)
    expect(data.first).to have_key(:name)
    expect(data.first).to have_key(:email)
    expect(data.first).to have_key(:phone_number)
    expect(data.first).to have_key(:role)
    expect(data.first).to have_key(:abilities)
    expect(data.first[:abilities]).to be_a Array
    expect(data.first[:abilities].length).to eq(2)
  end
end
