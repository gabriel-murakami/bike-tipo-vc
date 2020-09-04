# frozen_string_literal: true

class StationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end
end
