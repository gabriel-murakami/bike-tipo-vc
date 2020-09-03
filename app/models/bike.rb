# frozen_string_literal: true

class Bike < ApplicationRecord
  belongs_to :station
  has_many :trips, dependent: :nullify

  enum status: {
    available: 0,
    on_trip: 1,
    damaged: 2
  }
end
