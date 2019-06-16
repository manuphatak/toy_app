# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/edit', type: :view do
  let!(:micropost) { assign(:micropost, FactoryBot.build_stubbed(:micropost)) }

  it 'renders the edit micropost form' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('form[action=%p][method=%p]', micropost_path(micropost), 'post')
      expect(rendered).to have_selector format('textarea[name=%p]', 'micropost[content]')
      expect(rendered).to have_selector format('input[name=%p]', 'micropost[user_id]')
    end
  end
end
