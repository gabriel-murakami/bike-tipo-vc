# frozen_string_literal: true

class DevolutionService
  attr_reader :devolution_station, :bike

  def initialize(station:, bike:)
    @devolution_station = station
    @bike = bike
  end

  def execute
    return false if !station_different_from_initial? || devolution_station.full?

    ActiveRecord::Base.transaction do
      update_bike
      devolution_station.update_status
    end
  end

  private

  def update_bike
    bike.update(station: devolution_station)
    bike.available!
  end

  def station_different_from_initial?
    bike.station != devolution_station
  end
end
