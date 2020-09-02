# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WithdrawService, type: :service do
  subject(:service) {
    described_class.new(
      station: station,
      bike: bike
    )
  }

  describe '#execute' do
    let(:station) { build(:station, spots_number: 1, status: :full) }

    context 'when bike is not available' do
      let(:bike) { build(:bike, status: :damaged, station: station) }

      it 'returns false' do
        expect(service.execute).to eq false
      end
    end

    context 'when bike is available' do
      let(:bike) { create(:bike, status: :available, station: station) }

      it 'sets `on trip` status to the bike' do
        expect { service.execute }.to change { bike.status }.from('available').to('on_trip')
      end

      it 'updates status of the start station' do
        expect { service.execute }.to change { station.status }.from('full').to('empty')
      end
    end
  end
end
