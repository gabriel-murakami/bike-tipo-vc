# frozen_string_literal: true

FactoryBot.define do
  factory :bike do
    station { create(:station) }

    status { :available }
  end
end
