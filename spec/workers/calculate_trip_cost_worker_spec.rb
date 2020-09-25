# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe CalculateTripCostWorker, type: :worker do
  subject(:worker) { described_class.new }

  describe '#perform' do
    RSpec.shared_examples 'enqueue send notification worker' do
      it 'enqueues send notification worker' do
        expect {
          worker.perform(trip.user_id)
        }.to change(SendTripToPrefectureWorker.jobs, :size).by(1)
      end
    end

    context 'when the trip is less than or equal to one hour' do
      let(:trip) { create(:trip) }

      it 'sets the trip cost to zero' do
        expect { worker.perform(trip.user_id) }.to change { trip.reload.cost }.from(nil).to(0)
      end

      include_examples 'enqueue send notification worker'
    end

    context 'when the trip was longer than an hour' do
      let(:trip) { create(:trip, finish_time: Time.current, start_time: 160.minutes.ago) }

      it 'sets the calculated trip cost' do
        expect { worker.perform(trip.user_id) }.to change { trip.reload.cost }.from(nil).to(14.0)
      end

      include_examples 'enqueue send notification worker'
    end
  end
end
