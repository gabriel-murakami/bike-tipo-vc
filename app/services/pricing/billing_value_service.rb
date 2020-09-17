# frozen_string_literal: true

module Pricing
  class BillingValueService
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def execute
      trips.sum(&:cost)
    end

    private

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
