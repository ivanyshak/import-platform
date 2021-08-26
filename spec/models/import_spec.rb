require 'rails_helper'

RSpec.describe Import, type: :model do
  context 'validations' do
    it 'has valid factory' do
      expect(build(:import)).to be_valid
      expect(create(:import)).to be_valid
    end

    it { should validate_presence_of(:title) }
  end
end
