# frozen_string_literal: true

class DevolutionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if service.new(station: station, bike: bike, user: current_user).execute
      redirect_to stations_url, notice: I18n.t('trips.devolution.success') % { bike_id: bike.id, station_name: station.name }
    else
      redirect_to stations_url, alert: I18n.t('trips.devolution.failed')
    end
  end

  private

  def service
    service ||= DevolutionService
  end

  def station
    station ||= Station.find(params[:station_id])
  end

  def bike
    bike ||= Bike.find(params[:bike_id])
  end
end
