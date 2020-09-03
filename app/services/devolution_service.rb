# frozen_string_literal: true

class DevolutionService
  attr_reader :devolution_station, :bike, :user

  def initialize(station:, bike:, user:)
    @devolution_station = station
    @bike = bike
    @user = user
  end

  def execute
    return false if !station_different_from_initial? || devolution_station.full?

    ActiveRecord::Base.transaction do
      update_bike
      user.update(bike: nil)
      devolution_station.update_status
      finish_trip
    end
  end

  private

  def finish_trip
    trip = Trip.where(user_id: user.id).last
    trip.update(finish_time: Time.now, finish_station: devolution_station)
  end

  def update_bike
    bike.update(station: devolution_station)
    bike.available!
  end

  def station_different_from_initial?
    bike.station != devolution_station
  end
end
