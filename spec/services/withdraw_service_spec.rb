# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WithdrawService, type: :service do
  subject(:service) do
    described_class.new(
      station: station,
      bike: bike,
      user: user
    )
  end

  describe '#execute' do
    let(:station) { build(:station, spots_number: 1, status: :full) }
    let(:user) { build(:user, bike: nil) }

    context 'when bike is not available' do
      let(:bike) { build(:bike, status: :damaged, station: station) }

      it 'returns false' do
        expect(service.execute).to eq false
      end
    end

    context 'when user already have a bike' do
      let(:user) { build(:user, bike: build(:bike)) }
      let(:bike) { build(:bike, status: :available, station: station) }

      it 'returns false' do
        expect(service.execute).to eq false
      end
    end

    context 'when bike is available and user not have a bike' do
      let(:bike) { create(:bike, status: :available, station: station) }

      it 'sets `on trip` status to the bike' do
        expect { service.execute }.to change { bike.status }.from('available').to('on_trip')
      end

      it 'updates status of the start station' do
        expect { service.execute }.to change { station.status }.from('full').to('empty')
      end

      it 'creates relations between current user and the bike' do
        expect { service.execute }.to change { user.bike }.from(nil).to(bike)
      end

      it 'creates a new trip' do
        expect { service.execute }.to change { Trip.all.count }.from(0).to(1)
      end
    end
  end
end
