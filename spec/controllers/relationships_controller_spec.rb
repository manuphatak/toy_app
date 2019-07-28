# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe RelationshipsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Relationship. As you add validations to Relationship, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RelationshipsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Relationship.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      relationship = Relationship.create! valid_attributes
      get :show, params: { id: relationship.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      relationship = Relationship.create! valid_attributes
      get :edit, params: { id: relationship.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Relationship' do
        expect do
          post :create, params: { relationship: valid_attributes }, session: valid_session
        end.to change(Relationship, :count).by(1)
      end

      it 'redirects to the created relationship' do
        post :create, params: { relationship: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Relationship.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { relationship: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested relationship' do
        relationship = Relationship.create! valid_attributes
        put :update, params: { id: relationship.to_param, relationship: new_attributes }, session: valid_session
        relationship.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the relationship' do
        relationship = Relationship.create! valid_attributes
        put :update, params: { id: relationship.to_param, relationship: valid_attributes }, session: valid_session
        expect(response).to redirect_to(relationship)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        relationship = Relationship.create! valid_attributes
        put :update, params: { id: relationship.to_param, relationship: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested relationship' do
      relationship = Relationship.create! valid_attributes
      expect do
        delete :destroy, params: { id: relationship.to_param }, session: valid_session
      end.to change(Relationship, :count).by(-1)
    end

    it 'redirects to the relationships list' do
      relationship = Relationship.create! valid_attributes
      delete :destroy, params: { id: relationship.to_param }, session: valid_session
      expect(response).to redirect_to(relationships_url)
    end
  end
end
