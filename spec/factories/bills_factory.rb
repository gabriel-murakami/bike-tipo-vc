# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    user { build(:user) }
    value { 250.0 }
    expire_at { "2020-09-30" }
  end
end
