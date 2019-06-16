# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) do
    FactoryBot.attributes_for(:user)
  end

  let(:invalid_attributes) do
    {
      name: 'Test User',
      email: 'test.user',
      password: 'password',
      password_confirmation: 'pas$word'
    }
  end

  describe 'GET #index' do
    before { :user }
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user.id }
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
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { user: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested user' do
        put :update, params: { id: user.id, user: valid_attributes }

        aggregate_failures do
          user.reload
          expect(user.name).to eq(valid_attributes[:name])
          expect(user.email).to eq(valid_attributes[:email])
        end
      end

      it 'redirects to the user' do
        put :update, params: { id: user.id, user: valid_attributes }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    before { user }
    it 'destroys the requested user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end
end
