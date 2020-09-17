# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    user { create(:user) }

    value { 250.0 }
    expires_at { "2020-09-30" }
  end
end
