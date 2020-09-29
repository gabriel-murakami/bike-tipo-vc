# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = Trip.where(user: current_user).order(finish_time: :desc).select do |trip|
      trip.finish_station.present? && trip.finish_time > Date.current.prev_month
    end

    @actual_bill_value = @trips.sum(&:cost)
  end
end
