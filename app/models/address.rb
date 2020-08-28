# frozen_string_literal: true

class Address < ApplicationRecord
  has_one :station, dependent: :destroy
end
