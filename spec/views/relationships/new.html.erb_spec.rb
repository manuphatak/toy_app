# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'relationships/new', type: :view do
  before(:each) do
    assign(:relationship, Relationship.new(
                            follower_id: nil,
                            followed_id: nil
                          ))
  end

  it 'renders new relationship form' do
    render

    assert_select 'form[action=?][method=?]', relationships_path, 'post' do
      assert_select 'input[name=?]', 'relationship[follower_id_id]'

      assert_select 'input[name=?]', 'relationship[followed_id_id]'
    end
  end
end
