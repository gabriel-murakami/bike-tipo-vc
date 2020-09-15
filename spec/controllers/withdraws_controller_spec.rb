# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WithdrawsController, type: :controller do
  describe 'POST /withdraws' do
    context 'when user is not logged' do
      it 'redirect to new user session path' do
        get :create

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged' do
      before { sign_in(create(:user, bike: nil)) }

      let(:station) { create(:station, spots_number: 1, status: :empty) }
      let(:bike) { create(:bike, status: status, station: station) }

      context 'and when selected bike is not available' do
        let(:status) { 'damaged' }

        it 'redirect to stations with error message' do
          post :create, params: { bike_id: bike.id, station_id: station.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['alert']).to eq 'Não foi possível alugar esta bike'
        end
      end

      context 'and when selected bike is available' do
        let(:status) { 'available' }

        it 'redirect to stations with success message' do
          post :create, params: { bike_id: bike.id, station_id: station.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['notice']).to eq "Bike #{bike.id} alugada com sucesso"
        end
      end
    end
  end
end
