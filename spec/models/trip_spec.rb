# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trip, type: :model do
  subject(:trip) { described_class }

  let(:start_station) { build(:station, name: 'Moema') }
  let(:finish_station) { build(:station) }
  let(:bike) { build(:bike) }
  let(:user) { build(:user) }

  describe '#start_trip' do
    it 'starts a trip' do
      expect {
        trip.start_trip(bike: bike, user: user, start_station: start_station)
      }.to change { Trip.count }.by(1)
    end
  end

  describe '#finish_trip' do
    context 'when not finds a started trip' do
      let(:other_user) { build(:user) }

      it 'raises an error' do
        expect { trip.finish_trip(user: other_user, finish_station: finish_station) }.to raise_error(StandardError)
      end
    end

    context 'when finds a started trip' do
      it 'finishes a trip' do
        trip.start_trip(bike: bike, user: user, start_station: start_station)

        expect {
          trip.finish_trip(user: user, finish_station: finish_station)
        }.to change { Trip.last.finish_station }.from(nil).to(finish_station)
      end
    end
  end
end
