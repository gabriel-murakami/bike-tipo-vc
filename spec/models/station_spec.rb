# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Station, type: :model do
  subject(:station) { create(:station) }
  let(:bike) { create(:bike) }

  before do
    bike.station = station
    bike.save
  end

  describe '#update_status' do
    it 'updates station status' do
      expect { station.update_status }.to change { station.status }.from('empty').to('spots_available')
    end
  end

  describe '#vacancy_number' do
    it { expect(station.vacancy_number).to eq 9 }
  end

  describe '#bikes_on_station' do
    it { expect(station.bikes_on_station).to eq 1 }
  end

  describe '#damaged_bikes' do
    it { expect(station.damaged_bikes).to be_zero }
  end

  describe '#available_bikes' do
    it { expect(station.available_bikes).to eq 1 }
  end

  describe '#bikes_on_trip' do
    it { expect(station.bikes_on_trip).to be_zero }
  end
end
