require 'rails_helper'

describe ImportProcessingService do
  let!(:import) { create(:import) }
  let(:service) { described_class.new(import) }

  describe '#call!' do
    it 'updates state' do
      expect { service.call! }.to change(import, :state).from('created').to('completed')
    end

    context 'attachment is not present' do
      it 'does not increment invalid customer' do
        expect { service.call! }.not_to change(import, :invalid_customers)
      end

      it 'does not increment Customers count' do
        expect { service.call! }.not_to change { Customer.count }
      end
    end

    context 'attachment present' do
      pending 'add some examples after uploading CSV'
    end
  end
end
