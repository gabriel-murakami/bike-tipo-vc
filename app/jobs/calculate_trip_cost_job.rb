# frozen_string_literal: true

class CalculateTripCostJob < ApplicationJob
  queue_as 'bike-tipo-vc.job.calculate-trip-cost'

  def perform(trip)
    trip.update!(cost: PricingService::TripCostCalculator.new(trip: trip).calculate)

    SendTripToPrefectureJob.perform_later(trip)
  end
end
