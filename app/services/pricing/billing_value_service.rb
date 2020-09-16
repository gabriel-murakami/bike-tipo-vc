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
      @trips ||= user.trips.where(
        'finish_time >= ? AND finish_time < ?',
        30.days.ago.beginning_of_day,
        Date.current.beginning_of_day
      )
    end
  end
end
