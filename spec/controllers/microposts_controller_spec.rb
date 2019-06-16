# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:valid_attributes) { { content: 'This is a micropost', user_id: FactoryBot.create(:user).id } }
  let(:invalid_attributes) { { content: '', user_id: nil } }

  describe 'GET #index' do
    before { micropost }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: micropost.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: micropost.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Micropost' do
        expect do
          post :create, params: { micropost: valid_attributes }
        end.to change(Micropost, :count).by(1)
      end

      it 'redirects to the created micropost' do
        post :create, params: { micropost: valid_attributes }
        expect(response).to redirect_to(Micropost.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { micropost: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested micropost' do
        put :update, params: { id: micropost.id, micropost: valid_attributes }
        aggregate_failures do
          micropost.reload
          expect(micropost.content).to eq(valid_attributes[:content])
          expect(micropost.user_id).to eq(valid_attributes[:user_id])
        end
      end

      it 'redirects to the micropost' do
        put :update, params: { id: micropost.id, micropost: valid_attributes }
        expect(response).to redirect_to(micropost)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: micropost.id, micropost: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    before { micropost }
    it 'destroys the requested micropost' do
      expect { delete :destroy, params: { id: micropost.id } }.to change(Micropost, :count).by(-1)
    end

    it 'redirects to the microposts list' do
      delete :destroy, params: { id: micropost.id }
      expect(response).to redirect_to(microposts_url)
    end
  end
end
