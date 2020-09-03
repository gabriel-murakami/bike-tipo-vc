# frozen_string_literal: true

class Station < ApplicationRecord
  belongs_to :address
  has_many :trips
  has_many :bikes, dependent: :destroy

  enum status: {
    full: 0,
    empty: 1,
    spots_available: 2
  }

  def update_status
    if bikes_on_station == self.spots_number
      self.full!
    elsif bikes_on_station.zero?
      self.empty!
    else
      self.spots_available!
    end
  end

  def spots_available_number
    self.spots_number - bikes_on_station
  end

  def bikes_on_station
    self.bikes.count { |bike| bike.status != 'on_trip' }
  end

  def bikes_on_trip
    self.bikes.count { |bike| bike.status == 'on_trip' }
  end
end
