# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevolutionsController, type: :controller do
  describe 'POST /devolutions' do
    context 'when user is not logged' do
      it 'redirects to new user session path' do
        get :create

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged' do
      before { sign_in(user) }

      let(:withdraw_station) { create(:station, name: 'A', spots_number: 1, status: :empty) }
      let(:devolution_station) { create(:station, name: 'B', spots_number: 1, status: devolution_status) }
      let(:bike) { create(:bike, status: 'on_trip', station: withdraw_station) }
      let(:user) { create(:user, bike: nil) }

      context 'and when devolution station is full' do
        let(:devolution_status) { :full }

        it 'redirects to stations with error message' do
          post :create, params: { bike_id: bike.id, station_id: devolution_station.id, current_user: user.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['alert']).to eq 'Não foi possível devolver esta bike'
        end
      end

      context 'and when devolution station is same as withdraw station' do
        it 'redirects to stations with error message' do
          post :create, params: { bike_id: bike.id, station_id: withdraw_station.id, current_user: user.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['alert']).to eq 'Não foi possível devolver esta bike'
        end
      end

      context 'and when devolution station is available' do
        before { allow(Trip).to receive(:where).and_return([trip]) }

        let(:devolution_status) { :empty }
        let(:trip) { create(:trip, bike: bike, user: user, start_station: withdraw_station, finish_station: nil) }

        it 'redirects to stations with success message' do
          post :create, params: { bike_id: bike.id, station_id: devolution_station.id, current_user: user.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['notice']).to eq "Bike #{bike.id} devolvida com sucesso para #{devolution_station.name}"
        end
      end
    end
  end
end
