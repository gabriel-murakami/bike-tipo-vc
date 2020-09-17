# frozen_string_literal: true

class BillingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if authorized_ip?
      users = User.all.to_a
      SendBillingNotificationJob.perform_later(users)
      head :ok
    else
      head :unauthorized
    end
  end

  private

  def authorized_ip?
    request.remote_ip == ENV['TEMPORIZER_IP']
  end
end
