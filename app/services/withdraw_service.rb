# frozen_string_literal: true

class WithdrawService
  attr_reader :withdraw_station, :bike

  def initialize(station:, bike:)
    @withdraw_station = station
    @bike = bike
  end

  def execute
    return false unless bike.available?

    ActiveRecord::Base.transaction do
      bike.on_trip!
      withdraw_station.update_status
    end
  end
end
