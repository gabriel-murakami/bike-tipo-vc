# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :bike
  belongs_to :user
  belongs_to :start_station, class_name: 'Station'
  belongs_to :finish_station, class_name: 'Station', optional: true

  scope :user_trips, -> (current_user) do
    where(user: current_user).order(finish_time: :desc).select do |trip|
       trip.finish_station.present? && trip.finish_time > Date.current.prev_month
    end
  end

  def self.start_trip(bike:, user:, start_station:)
    create!(
      bike: bike,
      user: user,
      start_time: Time.current,
      start_station: start_station
    )
  end

  def self.finish_trip(user:, finish_station:)
    where(user: user).last.update!(
      finish_time: Time.current,
      finish_station: finish_station
    )
  end
end
