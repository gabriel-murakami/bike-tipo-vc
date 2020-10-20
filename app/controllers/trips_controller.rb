# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = Trip.user_trips(current_user)

    @actual_bill_value = Pricing::BillingValueService.new(user: current_user, current_trips: @trips).execute
  end
end
