# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    before { sign_in user }
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    before { sign_in user }
    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    context 'when signed in as user' do
      before { sign_in user }

      it 'does not destroy the requested user' do
        expect do
          delete :destroy, params: { id: user.id }
        end.not_to change(User, :count)
      end

      it 'redirects to the users list' do
        delete :destroy, params: { id: user.id, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when signed in as admin' do
      let(:user) { FactoryBot.create(:admin) }
      before { sign_in user }

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
end
