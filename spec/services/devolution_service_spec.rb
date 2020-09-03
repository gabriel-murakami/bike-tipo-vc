# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevolutionService, type: :service do
  subject(:service) do
    described_class.new(
      station: devolution_station,
      bike: bike,
      user: user
    )
  end


  describe '#execute' do
    let(:devolution_station) { build(:station, spots_number: 1, status: :empty) }
    let(:bike) { build(:bike, status: :on_trip, station: devolution_station) }
    let(:user) { build(:user, bike: bike) }

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
      before do
        allow(Trip).to receive(:where).and_return([trip])
      end

      let(:devolution_station) { create(:station, spots_number: 1, status: :empty) }
      let(:withdrawing_station) { create(:station, spots_number: 1, status: :empty) }
      let(:bike) { build(:bike, status: :on_trip, station: withdrawing_station) }
      let(:trip) { build(:trip, bike: bike, user: user, start_station: withdrawing_station, finish_station: nil) }

      it 'sets `available` status to the bike' do
        expect { service.execute }.to change { bike.status }.from('on_trip').to('available')
      end

      it 'updates status of the start station' do
        expect { service.execute }.to change { devolution_station.status }.from('empty').to('full')
      end

      it 'updates user relation to the bike' do
        expect { service.execute }.to change { user.bike }.from(bike).to(nil)
      end

      it 'finishes a trip' do
        expect { service.execute }.to change { trip.finish_station }.from(nil).to(devolution_station)
      end
    end
  end
end
