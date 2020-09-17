# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillingsController, type: :controller do
  describe 'POST /billings' do
    context 'when ip is not authorized' do
      it 'returns status 401 (:unauthorized)' do
        post :create

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when ip is authorized' do
      before { controller.request.remote_addr = ENV['TEMPORIZER_IP'] }

      it 'returns status 200 (:ok)' do
        post :create

        expect(response).to have_http_status(:ok)
      end

      it 'enqueues billing notification job' do
        expect {
          post :create
        }.to have_enqueued_job(SendBillingNotificationJob).exactly(:once)
      end
    end
  end
end
