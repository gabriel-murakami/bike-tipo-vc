# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PricingService::Calculator::TripCostCalculator, type: :service do
  subject(:calculator) { described_class.new(trip: trip) }

  describe '#calculate' do
    context 'when the trip is less than or equal to one hour' do
      let(:trip) { build(:trip) }

      it 'returns zero' do
        expect(calculator.calculate).to be_zero
      end
    end

    context 'when the trip was longer than an hour' do
      let(:trip) { build(:trip, finish_time: Time.current, start_time: 160.minutes.ago) }

      it 'returns calculated trip cost' do
        expect(calculator.calculate).to eq 14.0
      end
    end
  end
end
