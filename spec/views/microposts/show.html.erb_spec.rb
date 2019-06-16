# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/show', type: :view do
  let!(:micropost) { assign(:micropost, FactoryBot.build_stubbed(:micropost)) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Content:/)
    expect(rendered).to match(/User/)
  end
end
