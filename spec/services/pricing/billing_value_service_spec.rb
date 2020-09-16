# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pricing::BillingValueService, type: :service do
  subject(:service) { described_class.new(user: user) }

  describe '#execute' do
    before do
      create(:trip, user: user, cost: 10.20)
      create(:trip, user: user, cost: 10.40)
      create(:trip, user: user, cost: 20.80)
    end

    let(:user) { create(:user) }

    it 'calculates bill value' do
      expect(service.execute).to eq 41.40
    end
  end
end
