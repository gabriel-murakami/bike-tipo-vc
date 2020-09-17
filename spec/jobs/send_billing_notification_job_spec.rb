# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendBillingNotificationJob, type: :job do
  subject(:job) { described_class.new }

  describe '#perform' do
    let(:users) {
      [
        create(:user, email: 'user1@bike.com'),
        create(:user, email: 'user2@bike.com'),
        create(:user, email: 'user3@bike.com')
      ]
    }

    it 'delivers billing emails' do
      expect {
        job.perform(users)
      }.to change { ActionMailer::Base.deliveries.count }.by(3)
    end

    it 'creates a bill for each user' do
      expect { job.perform(users) }.to change { Bill.count }.by(3)
    end
  end
end
