# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'admin@bike.com' }
    name { 'John' }
    password { '123456' }
    password_confirmation { '123456' }
    due_date { 1 }
  end
end
