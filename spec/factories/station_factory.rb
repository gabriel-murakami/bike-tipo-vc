FactoryBot.define do
  factory :station do
    address { build(:address) }

    status { :spots_available }
    name { 'Vila Olímpia' }
    spots_number { 10 }
  end
end
