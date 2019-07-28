# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/index', type: :view do
  let!(:relationships) { assign(:relationships, create_list(:relationship, 5)) }

  it 'renders a list of relationships' do
    render

    aggregate_failures do
      relationships.each do |relationship|
        expect(rendered).to have_selector 'tr>td', text: relationship.followed.to_param
        expect(rendered).to have_selector 'tr>td', text: relationship.follower.to_param
      end
    end
  end
end
