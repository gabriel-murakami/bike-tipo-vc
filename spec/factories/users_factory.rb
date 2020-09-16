# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'admin@bike.com' }
    name { 'John' }
    password { '123bike' }
    password_confirmation { '123bike' }
  end
end
