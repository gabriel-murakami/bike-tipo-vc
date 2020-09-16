# frozen_string_literal: true

FactoryBot.define do
  factory :trip do
    bike { create(:bike) }
    user { create(:user) }
    start_station { create(:station) }
    finish_station { create(:station, name: 'Moema') }

    cost { nil }
    start_time { 25.minutes.ago - 1.day }
    finish_time { Time.current - 1.day }
  end
end
