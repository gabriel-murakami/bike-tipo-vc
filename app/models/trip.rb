# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :bike
  belongs_to :start_station, class_name: 'Station'
  belongs_to :finish_station, class_name: 'Station'
end
