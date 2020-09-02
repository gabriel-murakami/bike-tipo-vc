FactoryBot.define do
  factory :bike do
    station { build(:station) }

    status { :available }
  end
end
