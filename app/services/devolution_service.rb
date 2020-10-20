# frozen_string_literal: true

class DevolutionService
  attr_reader :devolution_station, :bike, :user

  def initialize(station:, bike:, user:)
    @devolution_station = station
    @bike = bike
    @user = user
  end

  def execute
    return false if same_station_from_initial? || devolution_station.full?

    ActiveRecord::Base.transaction do
      update_bike
      user.update(bike: nil)
      devolution_station.update_status

      Trip.finish_trip(user: user, finish_station: devolution_station)
    end

    CalculateTripCostWorker.perform_async(user.id)
  end

  private

  def update_bike
    bike.update!(station: devolution_station, status: :available)
  end

  def same_station_from_initial?
    bike.station == devolution_station
  end
end
