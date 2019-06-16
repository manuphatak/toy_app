# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/new', type: :view do
  before { assign(:micropost, FactoryBot.build(:micropost)) }

  it 'renders new micropost form' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('form[action=%p][method=%p]', microposts_path, 'post')
      expect(rendered).to have_selector format('textarea[name=%p]', 'micropost[content]')
      expect(rendered).to have_selector format('input[name=%p]', 'micropost[user_id]')
    end
  end
end
