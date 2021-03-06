# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint           not null
#  follower_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id)
#  fk_rails_...  (follower_id => users.id)
#

require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:valid_attributes) { { followed_id: create(:user).id } }
  let(:invalid_attributes) { { followed_id: 15 } }

  describe 'GET #index' do
    before { sign_in current_user }
    subject!(:relationships) { create_list(:relationship, 5) }

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before { sign_in current_user }
    context 'with valid params' do
      it 'creates a new Relationship' do
        valid_attributes

        expect do
          post :create, params: { relationship: valid_attributes }
        end.to change(Relationship, :count).by(1)
      end

      it 'redirects to the created relationship' do
        post :create, params: { relationship: valid_attributes }
        expect(response).to redirect_to(user_path(valid_attributes[:followed_id]))
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in current_user }
    subject!(:relationship) { create(:relationship, follower: current_user) }

    it 'destroys the requested relationship' do
      expect do
        delete :destroy, params: { id: relationship.to_param }
      end.to change(Relationship, :count).by(-1)
    end

    it 'redirects to the followed profile' do
      delete :destroy, params: { id: relationship.to_param }
      expect(response).to redirect_to(relationship.followed)
    end
  end
end
