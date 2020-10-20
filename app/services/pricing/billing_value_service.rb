# frozen_string_literal: true

module Pricing
  class BillingValueService
    attr_reader :user, :current_trips

    def initialize(user:, current_trips: nil)
      @user = user
      @current_trips = current_trips
    end

    def execute
      current_trips ? calculate(current_trips) : calculate(trips)
    end

    private

    def calculate(trips)
      trips.sum(&:cost)
    end

    def trips
      prev_month = Date.current.prev_month

      @trips ||= user.trips.where(
        'finish_time >= ? AND finish_time < ?',
        prev_month.beginning_of_month,
        prev_month.end_of_month
      )
    end
  end
end
