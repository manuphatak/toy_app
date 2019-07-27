# frozen_string_literal: true

json.array! @relationships, partial: 'relationships/relationship', as: :relationship
