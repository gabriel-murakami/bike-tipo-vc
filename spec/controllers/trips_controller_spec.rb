# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe 'GET /trips' do
    context 'when user is not logged' do
      it 'redirects to new user session path' do
        get :index

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged' do
      before { sign_in(create(:user, bike: nil)) }

      it 'returns status 200 (:ok)' do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
