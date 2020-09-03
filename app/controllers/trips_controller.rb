# frozen_string_literal: true

class TripsController < ApplicationController
  before_action :authenticate_user!

  def create
    station = Station.find(params[:station_id])
    bike = Bike.find(params[:bike_id])

    if params[:service] == 'withdraw'
      if WithdrawService.new(station: station, bike: bike, user: current_user).execute
        redirect_to stations_url, notice: "Bike #{bike.id} alugada com sucesso"
      else
        redirect_to stations_url, notice: 'Não foi possível alugar esta bike'
      end
    elsif params[:service] == 'devolution'
      if DevolutionService.new(station: station, bike: bike, user: current_user).execute
        redirect_to stations_url, notice: "Bike #{bike.id} devolvida com sucesso para #{station.name}"
      else
        redirect_to stations_url, notice: 'Não foi possível devolver esta bike'
      end
    end
  end
end
