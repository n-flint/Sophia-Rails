require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'relationships' do
    it { should belong_to :client}
  end
  describe 'validations' do
    it { should validate_presence_of :name}
  end
end