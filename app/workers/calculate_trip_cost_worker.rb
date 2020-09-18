# frozen_string_literal: true

class CalculateTripCostWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    trip = Trip.where(user: user_id).last
    trip_cost = Pricing::TripCostService.new(trip: trip).execute
    trip.update!(cost: trip_cost)

    SendTripToPrefectureWorker.perform_async(trip.id)
  end
end
