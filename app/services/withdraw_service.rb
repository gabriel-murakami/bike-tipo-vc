# frozen_string_literal: true

class WithdrawService
  attr_reader :withdraw_station, :bike, :user

  def initialize(station:, bike:, user:)
    @withdraw_station = station
    @bike = bike
    @user = user
  end

  def execute
    return false if !bike.available? || !user.bike.nil?

    ActiveRecord::Base.transaction do
      bike.on_trip!
      user.update(bike: bike)
      withdraw_station.update_status

      Trip.start_trip(bike: bike, user: user, start_station: withdraw_station)
    end
  end
end
