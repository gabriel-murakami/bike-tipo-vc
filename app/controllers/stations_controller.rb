# frozen_string_literal: true

class StationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stations = Station.all
  end
end
