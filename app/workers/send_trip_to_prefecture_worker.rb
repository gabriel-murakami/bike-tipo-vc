# frozen_string_literal: true

class SendTripToPrefectureWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(trip_id)
    trip = Trip.find(trip_id)
    RestClient.post(url, payload(trip).to_json, headers)
  end

  private

  def headers
    {
      'Authorization': 'Bearer ' + ENV['SPRINGFIELD_TOKEN'],
      'content-Type': 'application/json'
    }
  end

  def payload(trip)
    {
      user_id: trip.user_id.to_i,
      bike_id: trip.bike_id.to_i,
      started_at: trip.start_time.strftime('%Y-%m-%d %H:%M:%S'),
      finished_at: trip.finish_time.strftime('%Y-%m-%d %H:%M:%S'),
      origin: {
        station_id: trip.start_station_id.to_i
      },
      destination: {
        station_id: trip.finish_station_id.to_i
      }
    }
  end

  def url
    ENV['SPRINGFIELD_API_URL']
  end
end
