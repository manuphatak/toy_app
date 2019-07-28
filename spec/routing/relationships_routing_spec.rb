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

RSpec.describe RelationshipsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/relationships').to route_to('relationships#index')
    end

    it 'routes to #new' do
      expect(get: '/relationships/new').to route_to('relationships#new')
    end

    it 'routes to #show' do
      expect(get: '/relationships/1').to route_to('relationships#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/relationships/1/edit').to route_to('relationships#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/relationships').to route_to('relationships#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/relationships/1').to route_to('relationships#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/relationships/1').to route_to('relationships#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/relationships/1').to route_to('relationships#destroy', id: '1')
    end
  end
end
