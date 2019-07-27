# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/index', type: :view do
  before(:each) do
    assign(:relationships, [
             Relationship.create!(
               follower_id: nil,
               followed_id: nil
             ),
             Relationship.create!(
               follower_id: nil,
               followed_id: nil
             )
           ])
  end

  it 'renders a list of relationships' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
