# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MODELS = [
  Trip,
  # User,
  Bike,
  Station,
  Address,
].freeze

puts 'Removing old seeds...'

MODELS.each do |model|
  begin
    model.destroy_all

    puts "Clean records of #{model} -> Success."
  rescue
    puts "Clean records of #{model} -> Error."
  end
end

puts 'Creating new seeds...'

puts 'Creating Addresses...'
address1 = Address.new(street: 'Rua Um', district: 'Bairro Um', city: 'Cidade Um', number: 100)
address2 = Address.new(street: 'Rua Dois', district: 'Bairro Dois', city: 'Cidade Dois', number: 100)
address3 = Address.new(street: 'Rua Três', district: 'Bairro Três', city: 'Cidade Três', number: 100)

address1.save
address2.save
address3.save

puts 'Creating Stations...'
station1 = Station.new(name: 'Moema', spots_number: 25)
station1.address = address1
station2 = Station.new(name: 'Chilon', spots_number: 10)
station2.address = address2
station3 = Station.new(name: 'Vila Olímpia', spots_number: 15)
station3.address = address3

station1.save
station2.save
station3.save


puts 'Creating Bikes...'
BIKE_STATUS = [:available, :damaged].freeze

stations = Station.all

stations.each do |station|
  number_of_bikes = Random.new.rand(1..station.spots_number)
  number_of_bikes.times do
    bike = Bike.new(status: BIKE_STATUS.sample)
    bike.station = station
    bike.save
  end
  station.update_status
end

puts 'Creating Trips...'

bikes = Bike.all

bikes.each do |bike|
  number_of_trips = Random.new.rand(0..3)
  number_of_trips.times do
    trip = Trip.new(
      bike: bikes.sample,
      start_station: stations.sample,
      finish_station: stations.sample,
      start_time: 30.minutes.ago,
      finish_time: Time.current
    )
    trip.save
  end
end

puts 'Creating User...'

user = User.new(
  email: 'admin@bike.com',
  password: '123456',
  password_confirmation: '123456',
  name: 'John',
  due_date: 1
)
user.save
