# frozen_string_literal: true

json.extract! relationship, :id, :follower_id, :followed_id, :created_at, :updated_at
json.url relationship_url(relationship, format: :json)
