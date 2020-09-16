# frozen_string_literal: true

module Pricing
  class TripCostService
    attr_reader :start_time, :finish_time

    PRICE_PER_5MIN = 0.20
    BASE_PRICE = 10.0

    def initialize(trip:)
      @start_time = trip.start_time
      @finish_time = trip.finish_time
    end

    def execute
      return 0 if finish_time - start_time <= 1.hour.seconds

      traveled_time_in_minutes = (finish_time - start_time - 1.hour.seconds) / 60

      variable_price = (traveled_time_in_minutes / 5) * PRICE_PER_5MIN

      (BASE_PRICE + variable_price).ceil(2)
    end
  end
end
