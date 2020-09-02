FactoryBot.define do
  factory :trip do
    bike { build(:bike) }
    start_station { build(:station) }
    finish_station { build(:station, name: 'Moema') }

    start_time { 25.minutes.ago }
    finish_time { Time.current }
  end
end
