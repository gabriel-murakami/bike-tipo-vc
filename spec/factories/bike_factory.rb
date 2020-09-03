# frozen_string_literal: true

FactoryBot.define do
  factory :bike do
    station { build(:station) }

    status { :available }
  end
end
