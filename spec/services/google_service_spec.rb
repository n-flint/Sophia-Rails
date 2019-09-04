require 'rails_helper'

RSpec.describe GoogleService, type: :service do
  before :each do
    @service = GoogleService.new
  end

  it "can turn audio to text" do
    text = @service.speech_to_text('./hello_there_test.flac')

    expect(text).to eq("hello there")
  end
end
