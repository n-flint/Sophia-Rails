require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'relationships' do
    it { should belong_to :list}
  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :priority }
  end
end
