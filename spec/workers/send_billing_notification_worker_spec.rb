# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SendBillingNotificationWorker, type: :worker do
  subject(:job) { described_class.new }

  describe '#perform' do
    let(:user) { create(:user, email: 'user1@bike.com') }

    it 'delivers billing emails' do
      expect {
        job.perform(user.due_date, user.id)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'creates a bill for each user' do
      expect { job.perform(user.due_date, user.id) }.to change { Bill.count }.by(1)
    end
  end
end
