# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let!(:user) { assign(:user, FactoryBot.build_stubbed(:user, name: 'Test User')) }

  it 'renders attributes in <p>' do
    render
    aggregate_failures do
      expect(rendered).to match(/alt="Test User"/)
      expect(rendered).to match(/Email/)
      expect(rendered).to match(/Posts/)
    end
  end
end
