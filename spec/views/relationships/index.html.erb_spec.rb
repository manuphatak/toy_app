# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/index', type: :view do
  let!(:relationships) do
    relationship_ids = create_list(:relationship, 5).pluck(:id)
    assign(:relationships, Relationship.where(id: relationship_ids).page(nil))
  end

  it 'renders a list of relationships' do
    render

    aggregate_failures do
      expect(rendered).to have_selector 'li.relationship', count: 5
    end
  end
end
