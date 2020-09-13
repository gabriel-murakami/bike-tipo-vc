# frozen_string_literal: true

FactoryBot.define do
  factory :trip do
    bike { build(:bike) }
    user { build(:user) }
    start_station { build(:station) }
    finish_station { build(:station, name: 'Moema') }

    cost { nil }
    start_time { 25.minutes.ago }
    finish_time { Time.current }
  end
end
