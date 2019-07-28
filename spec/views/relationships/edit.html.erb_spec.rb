# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/edit', type: :view do
  let!(:relationship) { assign(:relationship, create(:relationship)) }

  it 'renders the edit relationship form' do
    render

    assert_select 'form[action=?][method=?]', relationship_path(relationship), 'post' do
      assert_select 'input[name=?]', 'relationship[follower_id_id]'

      assert_select 'input[name=?]', 'relationship[followed_id_id]'
    end
  end
end
