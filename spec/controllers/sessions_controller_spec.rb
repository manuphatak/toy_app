# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    context 'with valid params' do
      let(:valid_params) { { session: { email: 'test@example.com', password: 'password', remember_me: '1' } } }
      it 'returns http success' do
        expect(controller).to receive(:login).with(user)
        expect(controller).to receive(:remember).with(user)

        post :create, params: valid_params
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid params' do
      it 'redirects back to #new given bad password' do
        invalid_params = { session: { email: 'test@example.com', password: 'pas$word' } }
        aggregate_failures do
          expect(controller).not_to receive(:login)
          post :create, params: invalid_params
          expect(flash[:danger]).to be_present
          expect(response).to have_http_status(:success)
        end
      end

      it 'redirects back to #new given unknown user' do
        invalid_params = { session: { email: 'unknown@example.com', password: 'password' } }
        aggregate_failures do
          expect(controller).not_to receive(:login)
          post :create, params: invalid_params

          expect(flash[:danger]).to be_present
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns http success' do
      aggregate_failures do
        expect(controller).to receive(:logout)
        delete :destroy, session: { user_id: user.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
