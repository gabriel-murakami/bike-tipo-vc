# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevolutionService, type: :service do
  subject(:service) {
    described_class.new(
      station: devolution_station,
      bike: bike
    )
  }

  describe '#execute' do
    let(:devolution_station) { build(:station, spots_number: 1, status: :empty) }
    let(:bike) { build(:bike, status: :on_trip, station: devolution_station) }

    context 'when devolution station is the same as withdrawing station' do
      it 'returns false' do
        expect(service.execute).to eq false
      end
    end

    context 'when devolution station is full' do
      let(:devolution_station) { build(:station, spots_number: 1, status: :full) }

      it 'returns false' do
        expect(service.execute).to eq false
      end
    end

    context 'when devolution station is different as withdrawing station' do
      let(:devolution_station) { create(:station, spots_number: 1, status: :empty) }
      let(:withdrawing_station) { create(:station, spots_number: 1, status: :empty) }
      let(:bike) { build(:bike, status: :on_trip, station: withdrawing_station) }

      it 'sets `available` status to the bike' do
        expect { service.execute }.to change { bike.status }.from('on_trip').to('available')
      end

      it 'updates status of the start station' do
        expect { service.execute }.to change { devolution_station.status }.from('empty').to('full')
      end
    end
  end
end
