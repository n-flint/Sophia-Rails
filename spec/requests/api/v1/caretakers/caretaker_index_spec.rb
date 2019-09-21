require 'rails_helper'

RSpec.describe 'Caretakers API' do
  before :each do
    @caretaker1 = create(:caretaker)
    @caretaker2 = create(:caretaker)
  end
  it 'can return a list of all the caretakers' do
    get '/api/v1/caretakers'

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[0][:username]).to eq(@caretaker1.username)
    expect(data[0][:name]).to eq(@caretaker1.name)
    expect(data[0][:email]).to eq(@caretaker1.email)
    expect(data[0][:phone_number]).to eq(@caretaker1.phone_number)
    expect(data[0][:abilities]).to include(@caretaker1.abilities.split(', ').first)
    expect(data[0][:abilities]).to include(@caretaker1.abilities.split(', ').second)
    expect(data[0][:role]).to eq(@caretaker1.role)
    expect(data[1][:username]).to eq(@caretaker2.username)
    expect(data[1][:name]).to eq(@caretaker2.name)
    expect(data[1][:email]).to eq(@caretaker2.email)
    expect(data[1][:phone_number]).to eq(@caretaker2.phone_number)
  end
end
