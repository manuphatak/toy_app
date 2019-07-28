# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/show', type: :view do
  subject!(:relationship) { assign(:relationship, create(:relationship)) }

  it 'renders attributes in <p>' do
    render

    aggregate_failures do
      expect(rendered).to have_selector 'p', text: relationship.followed.to_param
      expect(rendered).to have_selector 'p', text: relationship.follower.to_param
    end
  end
end
