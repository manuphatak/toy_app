# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'static_pages/home.html.erb', type: :view do
  it 'renders the edit user form' do
    render

    assert_select 'title', 'Toy App'
  end
end
