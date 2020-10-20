# frozen_string_literal: true

class WithdrawsController < ApplicationController
  before_action :authenticate_user!

  def create
    if service.new(station: station, bike: bike, user: current_user).execute
      redirect_to stations_url, notice: I18n.t('trips.withdraw.success') % { bike_id: bike.id }
    else
      redirect_to stations_url, alert: I18n.t('trips.withdraw.failed')
    end
  end

  private

  def service
    service ||= WithdrawService
  end

  def station
    station ||= Station.find(params[:station_id])
  end

  def bike
    bike ||= Bike.find(params[:bike_id])
  end
end
