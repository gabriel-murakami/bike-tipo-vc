# frozen_string_literal: true

FactoryBot.define do
  factory :station do
    address { build(:address) }

    status { :empty }
    name { 'Vila Olímpia' }
    spots_number { 10 }
  end
end
