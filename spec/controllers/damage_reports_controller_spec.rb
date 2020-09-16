# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DamageReportsController, type: :controller do
  describe 'POST /damage_reports' do
    context 'when user is not logged' do
      it 'redirect to new user session path' do
        get :create

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged' do
      let(:bike) { create(:bike, status: status) }
      before { sign_in(create(:user, bike: nil)) }

      context 'and when selected bike is not available' do
        let(:status) { :on_trip }

        it 'returns to stations path with error' do
          post :create, params: { bike_id: bike.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['alert']).to eq 'Não foi possível reportar esta bike'
        end
      end

      context 'and when selected bike is available' do
        let(:status) { :available }

        it 'returns to stations path with success message' do
          post :create, params: { bike_id: bike.id }

          expect(response).to redirect_to(stations_path)
          expect(flash['notice']).to eq "Dano à bike #{bike.id} reportado com sucesso"
        end
      end
    end
  end
end
