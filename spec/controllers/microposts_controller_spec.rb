# frozen_string_literal: true

# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:micropost) { create(:micropost) }
  let(:valid_attributes) { attributes_for(:micropost, user_id: create(:user).id) }
  let(:invalid_attributes) { { content: '', user_id: nil } }

  describe 'GET #index' do
    context 'when not logged in' do
      it 'redirects to the home page' do
        get :index
        aggregate_failures do
          expect(response).to redirect_to root_path
          expect(flash.to_hash).to include('alert' => 'You are not authorized to access this page.')
        end
      end
    end
    context 'when logged in as admin' do
      before { sign_in create(:admin) }

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    before { sign_in create(:admin) }

    it 'returns a success response' do
      get :show, params: { id: micropost.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before { sign_in create(:admin) }

    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before { sign_in create(:admin) }

    it 'returns a success response' do
      get :edit, params: { id: micropost.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before { sign_in create(:admin) }

    context 'with valid params' do
      it 'creates a new Micropost' do
        expect do
          post :create, params: { micropost: valid_attributes }
        end.to change(Micropost, :count).by(1)
      end

      it 'redirects to the created micropost' do
        post :create, params: { micropost: valid_attributes }

        aggregate_failures do
          expect(flash.to_h).to include('success' => 'Micropost was successfully created.')
          expect(response).to redirect_to(Micropost.last)
        end
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
    before { sign_in create(:admin) }

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

    context 'when not logged in' do
      specify { expect { delete :destroy, params: { id: micropost.id } }.not_to change(Micropost, :count) }
      it 'redirects to the home page' do
        delete :destroy, params: { id: micropost.id }

        aggregate_failures do
          expect(response).to redirect_to root_path
          expect(flash.to_hash).to include('alert' => 'You are not authorized to access this page.')
        end
      end
    end
    context 'when logged in as admin' do
      before { sign_in create(:admin) }

      specify { expect { delete :destroy, params: { id: micropost.id } }.to change(Micropost, :count).by(-1) }

      it 'redirects to the microposts list' do
        delete :destroy, params: { id: micropost.id }
        expect(response).to redirect_to(microposts_url)
      end
    end
  end
end
