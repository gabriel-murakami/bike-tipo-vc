# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = Trip.where(user: current_user)
  end
end
