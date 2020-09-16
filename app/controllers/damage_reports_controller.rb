# frozen_string_literal: true

class DamageReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    bike = Bike.find(params[:bike_id])

    if bike.available?
      bike.damaged!
      redirect_to stations_url, notice: I18n.t('bikes.damage_notification.success') % { bike_id: bike.id }
    else
      redirect_to stations_url, alert: I18n.t('bikes.damage_notification.failed')
    end
  end
end
