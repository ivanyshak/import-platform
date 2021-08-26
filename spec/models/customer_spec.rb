require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it 'has valid factory' do
      expect(build(:customer)).to be_valid
      expect(create(:customer)).to be_valid
    end

    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_presence_of(:date_of_birth) }
  end
end
