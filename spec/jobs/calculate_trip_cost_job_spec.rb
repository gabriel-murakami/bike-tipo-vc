# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateTripCostJob, type: :job do
  subject(:job) { described_class.new }

  describe '#perform' do
    context 'when the trip is less than or equal to one hour' do
      let(:trip) { build(:trip) }

      it 'sets the trip cost to zero' do
        expect { job.perform(trip) }.to change { trip.cost }.from(nil).to(0)
      end
    end

    context 'when the trip was longer than an hour' do
      let(:trip) { build(:trip, finish_time: Time.current, start_time: 160.minutes.ago) }

      it 'sets the calculated trip cost' do
        expect { job.perform(trip) }.to change { trip.cost }.from(nil).to(14.0)
      end
    end
  end
end
