# frozen_string_literal: true

class CalculateTripCostJob < ApplicationJob
  queue_as 'bike-tipo-vc.job.calculate-trip-cost'

  PRICE_PER_5MIN = 0.20
  BASE_PRICE = 10.0

  def perform(trip)
    trip.update!(cost: calculator(trip.start_time, trip.finish_time))

    SendTripToPrefectureJob.perform_later(trip)
  end

  private

  def calculator(start_time, finish_time)
    return 0 if finish_time - start_time <= 1.hour.seconds

    traveled_time_in_minutes = (finish_time - start_time - 1.hour.seconds) / 60

    variable_price = (traveled_time_in_minutes / 5) * PRICE_PER_5MIN

    (BASE_PRICE + variable_price).ceil(2)
  end
end
