# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    bike { build(:bike) }

    email { 'admin@bike.com' }
    password { '123bike' }
    password_confirmation { '123bike' }
  end
end
