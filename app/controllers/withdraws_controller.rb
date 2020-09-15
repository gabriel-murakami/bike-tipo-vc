# frozen_string_literal: true

class WithdrawsController < ApplicationController
  before_action :authenticate_user!

  def create
    station = Station.find(params[:station_id])
    bike = Bike.find(params[:bike_id])

    if WithdrawService.new(station: station, bike: bike, user: current_user).execute
      redirect_to stations_url, notice: I18n.t('trips.withdraw.success') % { bike_id: bike.id }
    else
      redirect_to stations_url, alert: I18n.t('trips.withdraw.failed')
    end
  end
end
