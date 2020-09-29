# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe User, type: :model do
  context 'when new user is created' do
    subject(:user) { build(:user) }

    it 'enqueues billing notification worker' do
      expect {
        user.save!
      }.to change(SendBillingNotificationWorker.jobs, :size).by(1)
    end
  end
end
